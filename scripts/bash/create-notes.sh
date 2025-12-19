#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"
check_root
FILENAME=".github/releases/notes.md"
TEMPLATE=".github/templates/notes.md"
mkdir -p ".github/releases"
if [ ! -f "$TEMPLATE" ]; then
    log_error "Template $TEMPLATE not found."
    exit 1
fi
cp "$TEMPLATE" "$FILENAME"
log_success "Created Release Notes template at $FILENAME"
