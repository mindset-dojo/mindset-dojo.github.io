#!/bin/bash
# .github/scripts/run_htmlproofer.sh
# Run HTMLProofer with dynamic URL swap for forked repos (ephemeral install)

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
bundle install --jobs 4 --retry 3

# Ensure site is built with production config
bundle exec jekyll build --config _config.yml,_config.production.yml

# ------------------------------
# Derive the baseurl for swap-urls
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

# ---- Run proofer, and if it fails, print ALL offending files ----
set +e
TMP_OUT="$(mktemp)"
"${CMD[@]}" 2>&1 | tee "$TMP_OUT"
PROOFER_STATUS=${PIPESTATUS[0]}
set -e

if [[ $PROOFER_STATUS -ne 0 ]]; then
  echo "HTMLProofer failed — extracting offending files…"

  # Grab lines like: "* At ./_site/.../index.html:28:"
  mapfile -t OFFENDER_PAIRS < <(
    awk 'match($0,/^\* At (.+):([0-9]+):/,a){print a[1] "\t" a[2]}' "$TMP_OUT"
  )

  if [[ ${#OFFENDER_PAIRS[@]} -eq 0 ]]; then
    echo "Could not parse offending files from HTMLProofer output."
    exit "$PROOFER_STATUS"
  fi

  # Build map: file -> line numbers (space-separated)
  declare -A FILE2LINES
  for pair in "${OFFENDER_PAIRS[@]}"; do
    f="${pair%%$'\t'*}"
    l="${pair##*$'\t'}"
    FILE2LINES["$f"]+="${FILE2LINES["$f"]:+ }$l"
  done

  # Helper: print a file with all failing lines marked
  print_file_with_marks() {
    local file="$1" lines_str="$2"
    # Dedup lines and load into awk map
    awk -v marks="$lines_str" '
      BEGIN{
        split(marks,tmp," "); 
        for(i in tmp){ m[tmp[i]]=1 } 
      }
      {
        if (m[FNR]) printf(">> %6d\t%s\n", FNR, $0);
        else        printf("   %6d\t%s\n", FNR, $0);
      }
    ' "$file"
  }

  # Dump each offending file once, with all its failing lines marked
  for file in "${!FILE2LINES[@]}"; do
    if [[ -f "$file" ]]; then
      echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      echo "┃ Rendering of failing file:"
      echo "┃   $file"
      echo "┃   failing lines: ${FILE2LINES["$file"]}"
      echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      print_file_with_marks "$file" "${FILE2LINES["$file"]}"
      echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    else
      echo "WARN: Could not find file on disk: $file"
    fi
  done

  # Preserve original non-zero exit
  exit "$PROOFER_STATUS"
fi

# If we get here, proofer passed
exit 0