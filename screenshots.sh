#!/usr/bin/env bash
set -euo pipefail

# Take screenshots of all generated HTML pages using Chrome headless.
# Writes PNGs to screenshots/ and a markdown summary to $GITHUB_STEP_SUMMARY.

SRC_DIR="${1:-public}"

mkdir -p screenshots

for f in "$SRC_DIR"/*.html; do
  name=$(basename "$f" .html)
  google-chrome --headless=new --no-sandbox --disable-gpu \
    --screenshot="screenshots/${name}.png" --window-size=1280,900 \
    "file://$(pwd)/$f"
done

if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
  echo "## Page Screenshots" >> "$GITHUB_STEP_SUMMARY"
  echo "Download the **page-screenshots** artifact to view rendered pages." >> "$GITHUB_STEP_SUMMARY"
  echo "" >> "$GITHUB_STEP_SUMMARY"
  echo "| Page | Theme |" >> "$GITHUB_STEP_SUMMARY"
  echo "|------|-------|" >> "$GITHUB_STEP_SUMMARY"
  for f in screenshots/*.png; do
    name=$(basename "$f" .png)
    theme=$(echo "$name" | grep -q kernel && echo kernel || echo ellegant)
    echo "| ${name} | ${theme} |" >> "$GITHUB_STEP_SUMMARY"
  done
fi
