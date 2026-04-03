#!/usr/bin/env bash
set -euo pipefail

# Take screenshots of all generated HTML pages using Chrome headless.
# Writes PNGs to screenshots/.

SRC_DIR="${1:-public}"

mkdir -p screenshots

for f in "$SRC_DIR"/*.html; do
  name=$(basename "$f" .html)
  google-chrome --headless=new --no-sandbox --disable-gpu \
    --screenshot="screenshots/${name}.png" --window-size=1280,900 \
    "file://$(pwd)/$f"
done
