#!/bin/bash
# .github/scripts/run_htmlproofer.sh
# Run HTMLProofer with dynamic URL swap for forked repos

set -euo pipefail

# Load CLI flags from your config file
if [[ -f ".github/config/htmlproofer.env" ]]; then
    # shellcheck source=/dev/null
    source .github/config/htmlproofer.env
else
    echo "ERROR: .github/config/htmlproofer.env not found" >&2
    exit 1
fi

# Build up CLI flags for HTMLProofer
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

# Ensure Jekyll is installed
if ! command -v jekyll >/dev/null 2>&1; then
    echo "Jekyll not found, installing..."
    gem install jekyll --no-document
else
    echo "Jekyll already installed"
fi

# Ensure site is built with production config
jekyll build --config _config.yml,_config.production.yml

# Dynamically read baseurl from _config.production.yml and remove quotes
BASEURL=$(grep "^baseurl:" _config.production.yml | awk '{print $2}' | tr -d '"')

# Ensure leading slash for consistency
if [[ -n "$BASEURL" && "${BASEURL:0:1}" != "/" ]]; then
    BASEURL="/$BASEURL"
fi

# Determine SWAP_ARGS for HTML-Proofer
if [[ -z "${BASEURL}" || "${BASEURL}" == "/" ]]; then
    SWAP_ARGS=""
else
    BASEURL_ESCAPED="${BASEURL//./\\.}"
    SWAP_ARGS="--swap-urls '^${BASEURL_ESCAPED}/:/'"
fi

echo "Using SWAP_ARGS: ${SWAP_ARGS}"
echo "Running HTMLProofer with flags: ${PROOFER_FLAGS[*]} ${SWAP_ARGS}"

# Ephemeral installation: only install if not already installed
if ! command -v htmlproofer >/dev/null 2>&1; then
    echo "HTMLProofer not found, installing..."
    gem install html-proofer --no-document
else
    echo "HTMLProofer already installed"
fi

# Run HTMLProofer directly
htmlproofer ./_site "${PROOFER_FLAGS[@]}" ${SWAP_ARGS}

