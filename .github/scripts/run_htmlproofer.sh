#!/bin/bash
# .github/scripts/run_htmlproofer.sh
# Run HTMLProofer with dynamic URL swap for forked repos
# Keeps HTMLProofer installed ephemerally, but uses the proven swap/exec style.

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
# Build up CLI flags for HTMLProofer
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
# Build the site with Jekyll (via Bundler) — keep this to avoid gem conflicts
# ------------------------------
if ! command -v bundle >/dev/null 2>&1; then
    echo "Bundler not found, installing..."
    gem install bundler --no-document
fi

# Use local vendor/bundle (recommended instead of deprecated --path)
bundle config set --local path 'vendor/bundle'
bundle install --jobs=4 --retry=3

# Build site using Bundler (resolves all Gemfile plugin version conflicts)
bundle exec jekyll build --config _config.yml,_config.production.yml

# ------------------------------
# Prepare dynamic URL swap (use the old/winning approach)
# ------------------------------
BASEURL=$(grep "^baseurl:" _config.production.yml | awk '{print $2}' | tr -d '"')

# Ensure leading slash
if [[ -n "$BASEURL" && "${BASEURL:0:1}" != "/" ]]; then
    BASEURL="/$BASEURL"
fi

SWAP_FLAG=""
SWAP_VAL=""

if [[ -z "${BASEURL}" || "${BASEURL}" == "/" ]]; then
    SWAP_FLAG=""
    SWAP_VAL=""
else
    BASEURL_ESCAPED="${BASEURL//./\\.}"
    SWAP_FLAG="--swap-urls"
    SWAP_VAL="^${BASEURL_ESCAPED}/:/"
fi

echo "Using SWAP_ARGS: ${SWAP_FLAG} ${SWAP_VAL}"
echo "Running HTMLProofer with flags: ${PROOFER_FLAGS[*]} ${SWAP_FLAG} ${SWAP_VAL}"

# ------------------------------
# Install and run HTMLProofer ephemerally (no Gemfile changes)
# ------------------------------
if ! command -v htmlproofer >/dev/null 2>&1; then
    echo "HTMLProofer not found, installing..."
    gem install html-proofer --no-document
else
    echo "HTMLProofer already installed"
fi

# Build the final command array (robust tokenization)
CMD=(htmlproofer "./_site")
if [[ ${#PROOFER_FLAGS[@]} -gt 0 ]]; then
    CMD+=("${PROOFER_FLAGS[@]}")
fi
if [[ -n "$SWAP_FLAG" ]]; then
    CMD+=("$SWAP_FLAG" "$SWAP_VAL")
fi

# Show exactly what will run, then exec
echo "Executing: ${CMD[*]}"
exec "${CMD[@]}"
