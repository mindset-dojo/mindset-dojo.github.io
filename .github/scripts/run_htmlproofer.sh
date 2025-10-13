#!/bin/bash
# .github/scripts/run_htmlproofer.sh
# Run HTMLProofer treating your absolute site URLs as internal (no URL swapping).

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

[[ "${ASSUME_EXTENSION:-false}" == "true" ]] && PROOFER_FLAGS+=(--assume-extension)
[[ "${ONLY_4XX:-false}"        == "true" ]] && PROOFER_FLAGS+=(--only-4xx)
[[ "${ENFORCE_HTTPS:-false}"   == "true" ]] && PROOFER_FLAGS+=(--enforce-https)
[[ -n "${IGNORE_URLS:-}" ]]                 && PROOFER_FLAGS+=(--ignore-urls="${IGNORE_URLS}")

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
# Determine internal domains
# ------------------------------
INTERNALS=""
if [[ -n "${INTERNAL_DOMAINS:-}" ]]; then
  INTERNALS="${INTERNAL_DOMAINS}"
else
  # Derive from _config.production.yml: url: https://mindset.dojo.center
  URL_VALUE=$(awk -F: '/^[[:space:]]*url[[:space:]]*:/ {print $2}' _config.production.yml | tr -d ' "')
  # Extract host (no scheme/path)
  HOST="${URL_VALUE#*://}"
  HOST="${HOST%%/*}"

  # Add apex + www variant if applicable
  if [[ "$HOST" =~ ^www\. ]]; then
    APEX="${HOST#www.}"
    INTERNALS="${HOST},${APEX}"
  else
    INTERNALS="${HOST},www.${HOST}"
  fi

  # Add any known first-party subdomains you use as internal (edit as needed)
  # Example keeps 'connect.' internal so it’s validated locally when absolute links appear.
  INTERNALS="${INTERNALS},connect.${HOST#www.}"
fi

echo "Using html-proofer flags: ${PROOFER_FLAGS[*]} --internal-domains ${INTERNALS}"

# ------------------------------
# Install and run HTMLProofer
# ------------------------------
if ! command -v htmlproofer >/dev/null 2>&1; then
  echo "HTMLProofer not found, installing..."
  gem install html-proofer --no-document
fi

CMD=(htmlproofer "./_site")
[[ ${#PROOFER_FLAGS[@]} -gt 0 ]] && CMD+=("${PROOFER_FLAGS[@]}")
CMD+=(--internal-domains "${INTERNALS}")

echo "Executing: ${CMD[*]}"
"${CMD[@]}"
