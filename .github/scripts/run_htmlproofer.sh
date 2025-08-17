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

# Make sure the site is built
bundle exec jekyll build

# Detect baseurl from _config.yml
BASEURL=$(bundle exec jekyll config baseurl)

# Determine SWAP_ARGS for htmlproofer
if [[ -z "${BASEURL}" || "${BASEURL}" == "/" ]]; then
  # Central repo or no baseurl
  SWAP_ARGS=""
else
  # Fork: replace baseurl with root for internal checks
  # Escape dots for regex
  BASEURL_ESCAPED="${BASEURL//./\\.}"
  # Swap /baseurl/... => /... so htmlproofer can find files in _site
  SWAP_ARGS="--swap_urls ^${BASEURL_ESCAPED}/:/"
fi

echo "Running HTMLProofer with flags: ${HTMLPROOFER_FLAGS} ${SWAP_ARGS}"
bundle exec htmlproofer ./_site ${HTMLPROOFER_FLAGS} ${SWAP_ARGS}
