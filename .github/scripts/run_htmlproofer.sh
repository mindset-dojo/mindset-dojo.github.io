#!/bin/bash
# .github/scripts/run_htmlproofer.sh
# Run HTMLProofer with a single URL swap for the canonical host (v5: --swap-urls with regex-escaped FROM).

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
# Derive site.url and construct a single --swap-urls pair (escaped regex)
# ------------------------------
URL_VALUE=""
if [[ -f "_config.production.yml" ]]; then
  # capture 'url: https://example.com' (ignore comments/spaces/quotes)
  URL_VALUE=$(awk -F: '/^[[:space:]]*url[[:space:]]*:/ {print $2}' _config.production.yml | tr -d ' "' || true)
fi

SWAP_ARG=""

# Priority 1: explicit ENV
if [[ -n "${URL_SWAP:-}" ]]; then
  # Accept proper v5 form "FROM_REGEX,TO_STRING" as-is
  if [[ "${URL_SWAP}" == *","* ]]; then
    SWAP_ARG="${URL_SWAP}"
  else
    # Legacy colon-style "https://host/:/" -> convert to v5 comma form
    if [[ "${URL_SWAP}" == http*":/" ]]; then
      LEFT="${URL_SWAP%:/}"         # strip the trailing ":/"
      LEFT="${LEFT%/}/"             # ensure single trailing slash
      RIGHT="/"                     # TO
      # Escape '.' and ':' and anchor at start ^
      LEFT_ESC="^$(printf '%s' "${LEFT}" | sed -e 's/[.]/\\./g' -e 's/:/\\:/g')"
      SWAP_ARG="${LEFT_ESC},${RIGHT}"
    else
      # Fallback: just replace the last ":/" with ",/"
      SWAP_ARG="${URL_SWAP%:/},/"
    fi
  fi

# Priority 2: derive from _config.production.yml:url
else
  if [[ -z "${URL_VALUE}" ]]; then
    echo "ERROR: site.url not set in _config.production.yml and URL_SWAP not provided; cannot build --swap-urls." >&2
    exit 1
  fi

  # Ensure trailing slash on canonical host
  CANON_URL="${URL_VALUE%/}/"

  # FROM is a regex. Escape '.' and ':' and anchor at start with ^
  FROM_RE="^$(printf '%s' "${CANON_URL}" | sed -e 's/[.]/\\./g' -e 's/:/\\:/g')"

  # v5 requires comma separator (FROM,TO)
  SWAP_ARG="${FROM_RE},/"
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
