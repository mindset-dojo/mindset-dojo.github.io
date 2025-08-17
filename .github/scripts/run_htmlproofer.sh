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

if [[ "${GITHUB_REPOSITORY}" == "mindset-dojo/mindset-dojo.github.io" ]]; then
  SWAP_ARGS=""
else
  REPO_NAME="$(basename "${GITHUB_REPOSITORY}")"
  PREFIX_ESCAPED="${REPO_NAME//./\\.}"
  SWAP_ARGS="--swap_urls ^/?${PREFIX_ESCAPED}:/ --swap_urls ^//:/"
fi

echo "Running HTMLProofer with flags: ${HTMLPROOFER_FLAGS} ${SWAP_ARGS}"
bundle exec htmlproofer ./_site ${HTMLPROOFER_FLAGS} ${SWAP_ARGS}
