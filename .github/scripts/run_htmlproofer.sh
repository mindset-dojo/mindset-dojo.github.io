#!/bin/bash
# Run HTMLProofer on Docker with dynamic URL swap

set -euo pipefail

# Load CLI flags from .env file
if [[ -f ".github/config/htmlproofer.env" ]]; then
    source .github/config/htmlproofer.env
else
    echo "ERROR: .github/config/htmlproofer.env not found" >&2
    exit 1
fi

# Build CLI flags array
PROOFER_FLAGS=()

[[ "${ASSUME_EXTENSION:-false}" == "true" ]] && PROOFER_FLAGS+=(--assume-extension)
[[ "${ONLY_4XX:-false}" == "true" ]] && PROOFER_FLAGS+=(--only-4xx)
[[ "${ENFORCE_HTTPS:-false}" == "true" ]] && PROOFER_FLAGS+=(--enforce-https)
[[ -n "${IGNORE_URLS:-}" ]] && PROOFER_FLAGS+=(--ignore-urls="${IGNORE_URLS}")

# Determine BASEURL from production config
BASEURL=$(grep "^baseurl:" _config.production.yml | awk '{print $2}' | tr -d '"')
[[ -n "$BASEURL" && "${BASEURL:0:1}" != "/" ]] && BASEURL="/$BASEURL"

# Determine SWAP_ARGS
SWAP_ARGS=()
[[ -n "$BASEURL" && "$BASEURL" != "/" ]] && SWAP_ARGS+=(--swap-urls "^${BASEURL//./\\.}/:/")

echo "Using SWAP_ARGS: ${SWAP_ARGS[*]}"
echo "Running HTMLProofer with flags: ${PROOFER_FLAGS[*]} ${SWAP_ARGS[*]}"

# Run HTMLProofer in Docker
docker run --rm \
    -v "${PWD}/_site:/site" \
    klakegg/html-proofer \
    /site \
    "${PROOFER_FLAGS[@]}" \
    "${SWAP_ARGS[@]}"
