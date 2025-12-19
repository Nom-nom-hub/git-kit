#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"

TITLE="$1"
if [ -z "$TITLE" ]; then
    log_error "Usage: $0 \"Design Title\""
    exit 1
fi

check_root

SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g')
FILENAME=".github/designs/${SLUG}.md"
TEMPLATE=".github/templates/design.md"

if [ ! -f "$TEMPLATE" ]; then
    log_error "Template $TEMPLATE not found. Run 'git-kit init'."
    exit 1
fi

cp "$TEMPLATE" "$FILENAME"
if [[ "$OSTYPE" == "darwin"* ]]; then
     sed -i '' "s/\[TITLE\]/$TITLE/g" "$FILENAME"
else
     sed -i "s/\[TITLE\]/$TITLE/g" "$FILENAME"
fi

log_success "Created Design Doc at $FILENAME"
