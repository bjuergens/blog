#!/usr/bin/env bash
set -euo pipefail

CONTENT_DIR="content"
TEMPLATE_ELLEGANT="template/layout-ellegant.html"
TEMPLATE_KERNEL="template/layout-kernel.html"
PUBLIC_DIR="public"

ELLEGANT_CSS_URL="https://raw.githubusercontent.com/ellegantcss/ellegant/main/ellegant.min.css"
KERNEL_CSS_URL="https://raw.githubusercontent.com/christian-dale/kernel.css/master/build/kernel.min.css"

# Clean & create output directories
rm -rf "$PUBLIC_DIR"
mkdir -p "$PUBLIC_DIR/css"

# Download CSS files
echo "Downloading CSS frameworks..."
curl -sL "$ELLEGANT_CSS_URL" -o "$PUBLIC_DIR/css/ellegant.min.css"
curl -sL "$KERNEL_CSS_URL" -o "$PUBLIC_DIR/css/kernel.min.css"

# Collect post listings for landing page (one per theme)
post_list_ellegant=""
post_list_kernel=""
for f in "$CONTENT_DIR"/[0-9][0-9][0-9][0-9]-*.md; do
  [ -e "$f" ] || continue
  filename=$(basename "$f" .md)
  title=$(grep -m1 '^title:' "$f" | sed 's/^title: *//')
  date=$(echo "$filename" | grep -oP '^\d{4}-\d{2}-\d{2}')
  post_list_ellegant="${post_list_ellegant}<li><time>${date}</time> &mdash; <a href=\"${filename}.html\">${title}</a></li>"
  post_list_kernel="${post_list_kernel}<li><time>${date}</time> &mdash; <a href=\"${filename}-kernel.html\">${title}</a></li>"
done

LISTING_ELLEGANT=$(mktemp)
LISTING_KERNEL=$(mktemp)
echo "<h2>Posts</h2><ul>${post_list_ellegant}</ul>" > "$LISTING_ELLEGANT"
echo "<h2>Posts</h2><ul>${post_list_kernel}</ul>" > "$LISTING_KERNEL"
trap 'rm -f "$LISTING_ELLEGANT" "$LISTING_KERNEL"' EXIT

# Build landing page (_root.md → index.html)
echo "Building landing page..."
pandoc "$CONTENT_DIR/_root.md" \
  --template="$TEMPLATE_ELLEGANT" \
  --standalone --to=html5 \
  -V theme-switch-url="index-kernel.html" \
  -A "$LISTING_ELLEGANT" \
  -o "$PUBLIC_DIR/index.html"

pandoc "$CONTENT_DIR/_root.md" \
  --template="$TEMPLATE_KERNEL" \
  --standalone --to=html5 \
  -V theme-switch-url="index.html" \
  -A "$LISTING_KERNEL" \
  -o "$PUBLIC_DIR/index-kernel.html"

# Build posts
for f in "$CONTENT_DIR"/[0-9][0-9][0-9][0-9]-*.md; do
  [ -e "$f" ] || continue
  slug=$(basename "$f" .md)
  echo "Building ${slug}..."

  pandoc "$f" \
    --template="$TEMPLATE_ELLEGANT" \
    --standalone --to=html5 \
    -V theme-switch-url="${slug}-kernel.html" \
    -o "$PUBLIC_DIR/${slug}.html"

  pandoc "$f" \
    --template="$TEMPLATE_KERNEL" \
    --standalone --to=html5 \
    -V theme-switch-url="${slug}.html" \
    -o "$PUBLIC_DIR/${slug}-kernel.html"
done

echo "Build complete. Output in $PUBLIC_DIR/"
ls -la "$PUBLIC_DIR/"
