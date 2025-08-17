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

# Ensure site is built
bundle exec jekyll build --config _config.yml,_config.production.yml

# Dynamically read baseurl from _config.production.yml
BASEURL=$(grep "^baseurl:" _config.production.yml | awk '{print $2}')

# Determine SWAP_ARGS for htmlproofer
if [[ -z "${BASEURL}" || "${BASEURL}" == "/" ]]; then
  SWAP_ARGS=""
else
  # Escape dots for regex and swap baseurl to root for internal checks
  BASEURL_ESCAPED="${BASEURL//./\\.}"
  SWAP_ARGS="--swap_urls ^${BASEURL_ESCAPED}/:/"
fi

echo "Running HTMLProofer with flags: ${HTMLPROOFER_FLAGS} ${SWAP_ARGS}"
bundle exec htmlproofer ./_site ${HTMLPROOFER_FLAGS} ${SWAP_ARGS}
