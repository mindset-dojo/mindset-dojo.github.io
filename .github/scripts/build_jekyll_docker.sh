#!/bin/bash
# Build Jekyll site in Docker for GitHub Pages

set -euo pipefail

# Ensure we're in the repository root
REPO_ROOT="$(pwd)"

# Run Jekyll build in Docker
docker run --rm \
    -v "${REPO_ROOT}:/srv/jekyll" \
    -v "${REPO_ROOT}/_site:/srv/jekyll/_site" \
    -e JEKYLL_ENV=production \
    jekyll/jekyll:3.8 \
    jekyll build --config _config.yml,_config.production.yml
