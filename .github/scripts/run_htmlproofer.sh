#!/bin/bash
# .github/scripts/run_htmlproofer.sh
# Run HTMLProofer with a single URL swap for the canonical host (v5: --swap-urls expects FROM:TO with escaped colons in FROM regex).

set -euo pipefail

# ------------------------------
# Load CLI flags from your config file
# ------------------------------
if [[ -f ".github/config/htmlproofer.env" ]]; then
  # shellcheck source=/dev/null
  source .github/config/htmlproofer.env
else
  echo "ERROR: .github/config/htmlproofer.env not found" >&2
  exit 1
fi

# ------------------------------
# Collect HTMLProofer flags from env
# ------------------------------
PROOFER_FLAGS=()

if [[ "${ASSUME_EXTENSION:-false}" == "true" ]]; then
  PROOFER_FLAGS+=(--assume-extension)
fi

if [[ "${ONLY_4XX:-false}" == "true" ]]; then
  PROOFER_FLAGS+=(--only-4xx)
fi

if [[ "${ENFORCE_HTTPS:-false}" == "true" ]]; then
  PROOFER_FLAGS+=(--enforce-https)
fi

if [[ -n "${IGNORE_URLS:-}" ]]; then
  PROOFER_FLAGS+=(--ignore-urls="${IGNORE_URLS}")
fi

# ------------------------------
# Build the site with Jekyll (via Bundler)
# ------------------------------
if ! command -v bundle >/dev/null 2>&1; then
  echo "Bundler not found, installing..."
  gem install bundler --no-document
fi

bundle config set --local path 'vendor/bundle'
bundle install --jobs 4 --retry 3

# Ensure site is built with production config
bundle exec jekyll build --config _config.yml,_config.production.yml

# ------------------------------
# Helpers
# ------------------------------
make_from_regex () {
  # Input: absolute canonical URL (e.g., https://example.com/ or https://example.com)
  # Output: anchored regex with escaped '.', ':', and '/' (v5 expects escaped literal colons)
  local src="$1"
  src="${src%/}/"  # ensure trailing slash
  printf '^%s' "$src" | sed -e 's/[.]/\\./g' -e 's/:/\\:/g' -e 's/\//\\\//g'
}

# ------------------------------
# Derive site.url and construct a single --swap-urls pair (escaped regex)
# ------------------------------
URL_VALUE=""
if [[ -f "_config.production.yml" ]]; then
  # capture 'url: https://example.com' (ignore quotes/whitespace)
  URL_VALUE=$(awk -F: '/^[[:space:]]*url[[:space:]]*:/ {print $2}' _config.production.yml | tr -d ' "' || true)
fi

SWAP_ARG=""

# Priority 1: explicit ENV
if [[ -n "${URL_SWAP:-}" ]]; then
  # Accept proper v5 colon form "FROM:TO" as-is (no comma present).
  if [[ "${URL_SWAP}" == *":"* && "${URL_SWAP}" != *","* ]]; then
    SWAP_ARG="${URL_SWAP}"
  else
    # If someone provided comma form "FROM,TO", auto-convert to colon form.
    if [[ "${URL_SWAP}" == *","* ]]; then
      LEFT="${URL_SWAP%%,*}"
      RIGHT="${URL_SWAP#*,}"
      if [[ "${LEFT}" == http* ]]; then
        LEFT_ESC=$(make_from_regex "${LEFT}")
      else
        LEFT_ESC="${LEFT}"
      fi
      SWAP_ARG="${LEFT_ESC}:${RIGHT}"
    else
      # Legacy naive like "https://host/:/" -> escape and fix.
      if [[ "${URL_SWAP}" == http*":/" ]]; then
        LEFT="${URL_SWAP%:/}"
        LEFT_ESC=$(make_from_regex "${LEFT}")
        SWAP_ARG="${LEFT_ESC}:/"
      else
        # Fallback: treat the whole thing as LEFT and map to root.
        LEFT_ESC=$(make_from_regex "${URL_SWAP}")
        SWAP_ARG="${LEFT_ESC}:/"
      fi
    fi
  fi

# Priority 2: derive from _config.production.yml:url
else
  if [[ -z "${URL_VALUE}" ]]; then
    echo "ERROR: site.url not set in _config.production.yml and URL_SWAP not provided; cannot build --swap-urls." >&2
    exit 1
  fi
  FROM_RE=$(make_from_regex "${URL_VALUE}")
  SWAP_ARG="${FROM_RE}:/"
fi

echo "Using html-proofer flags: ${PROOFER_FLAGS[*]} --swap-urls ${SWAP_ARG}"

# ------------------------------
# Install and run HTMLProofer ephemerally
# ------------------------------
if ! command -v htmlproofer >/dev/null 2>&1; then
  echo "HTMLProofer not found, installing..."
  gem install html-proofer --no-document
fi

CMD=(htmlproofer "./_site")
if [[ ${#PROOFER_FLAGS[@]} -gt 0 ]]; then
  CMD+=("${PROOFER_FLAGS[@]}")
fi
CMD+=(--swap-urls "${SWAP_ARG}")

echo "Executing: ${CMD[*]}"
"${CMD[@]}"
