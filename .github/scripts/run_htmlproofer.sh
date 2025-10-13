#!/bin/bash
# .github/scripts/run_htmlproofer.sh
# Run HTMLProofer with a single URL swap for the canonical host (no www/http variants).

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
# Derive site.url and construct a single --swap-urls flag (v5 syntax)
# ------------------------------
URL_VALUE=""
if [[ -f "_config.production.yml" ]]; then
  # capture 'url: https://example.com' (ignore comments/spaces/quotes)
  URL_VALUE=$(awk -F: '/^[[:space:]]*url[[:space:]]*:/ {print $2}' _config.production.yml | tr -d ' "' || true)
fi

SWAP_ARG=""

if [[ -n "${URL_SWAP:-}" ]]; then
  # Expect comma-separated pairs like: "https://example.com/:/"
  # html-proofer v5 expects one argument to --swap-urls with pairs joined by commas.
  SWAP_ARG="${URL_SWAP}"
else
  if [[ -z "${URL_VALUE}" ]]; then
    echo "ERROR: site.url not set in _config.production.yml and URL_SWAP not provided; cannot build --swap-urls." >&2
    exit 1
  fi
  CANON_URL="${URL_VALUE%/}/"
  # ONE canonical mapping: absolute → local root
  SWAP_ARG="${CANON_URL}:/"
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
