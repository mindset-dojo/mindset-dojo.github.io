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

# Determine if we’re in the central repo or a fork
if [[ "${GITHUB_REPOSITORY}" == "mindset-dojo/mindset-dojo.github.io" ]]; then
  # Central repo => no baseurl prefix, no need for swaps
  SWAP_ARGS=""
else
  # Fork => baseurl="/<repo>" in the build, so strip it for the internal checks
  REPO_NAME="$(basename "${GITHUB_REPOSITORY}")"
  PREFIX_ESCAPED="${REPO_NAME//./\\.}"

  # Two swaps:
  #   1) remove "/<reponame>" or "<reponame>" prefix (slash optional)
  #   2) collapse protocol-relative URLs ("//program") back to "/program"
  SWAP_ARGS="--swap_urls ^/?${PREFIX_ESCAPED}:/ --swap_urls ^//:/"
fi 

echo "Running HTMLProofer with flags: ${HTMLPROOFER_FLAGS} ${SWAP_ARGS}"
bundle exec htmlproofer ./_site ${HTMLPROOFER_FLAGS} ${SWAP_ARGS}
