#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"

NAME="$1"
if [ -z "$NAME" ]; then
    log_error "Usage: $0 \"Feature Name\""
    exit 1
fi

check_root

SLUG=$(echo "$NAME" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g')
FILENAME=".github/pr-plans/${SLUG}.md"
TEMPLATE=".github/templates/pr.md"

if [ ! -f "$TEMPLATE" ]; then
    log_warn "Template not found at $TEMPLATE. Using default."
    echo "# PR Plan: $NAME" > "$FILENAME"
else
    cp "$TEMPLATE" "$FILENAME"
fi

# Replace placeholders (simplistic)
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/\[PR Title\]/$NAME/g" "$FILENAME"
else
    sed -i "s/\[PR Title\]/$NAME/g" "$FILENAME"
fi

log_success "Created PR Plan at $FILENAME"
echo "Instructions: Edit the file to plan your implementation."
