#!/bin/bash
# .github/scripts/run_htmlproofer.sh
# Run HTMLProofer with dynamic URL swap for forked repos

set -euo pipefail

# Load common environment flags (must be defined in .github/config/htmlproofer.env)
if [[ -f ".github/config/htmlproofer.env" ]]; then
  # shellcheck source=/dev/null
  source .github/config/htmlproofer.env
else
  echo "ERROR: .github/config/htmlproofer.env not found" >&2
  exit 1
fi

# Compute repo name and escape dots for regex use
REPO_NAME="$(basename "$GITHUB_REPOSITORY")"
PREFIX_ESCAPED="${REPO_NAME//./\\.}"

# If this is NOT the central repo, prepare URL swap to strip prefix from internal links
if [[ "${GITHUB_REPOSITORY}" != "mindset-dojo/mindset-dojo.github.io" ]]; then
  URL_SWAP="--swap_urls ^/${PREFIX_ESCAPED}:/"
else
  URL_SWAP=""
fi

# Run HTMLProofer
echo "Running HTMLProofer with flags: ${HTMLPROOFER_FLAGS} ${URL_SWAP}"
bundle exec htmlproofer ./_site ${HTMLPROOFER_FLAGS} ${URL_SWAP}
