#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"
DATE=$(date +%Y-%m-%d)
check_root
FILENAME=".github/retros/${DATE}.md"
TEMPLATE=".github/templates/retro.md"
mkdir -p ".github/retros"
if [ ! -f "$TEMPLATE" ]; then
    log_error "Template $TEMPLATE not found."
    exit 1
fi
cp "$TEMPLATE" "$FILENAME"
log_success "Created Retrospective at $FILENAME"
