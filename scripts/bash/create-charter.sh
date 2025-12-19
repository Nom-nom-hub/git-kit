#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"
check_root
FILENAME=".github/CHARTER.md"
TEMPLATE=".github/templates/charter.md"
if [ ! -f "$TEMPLATE" ]; then
    log_error "Template $TEMPLATE not found."
    exit 1
fi
if [ -f "$FILENAME" ]; then
    log_warn "$FILENAME already exists. Skipping."
    exit 0
fi
cp "$TEMPLATE" "$FILENAME"
log_success "Created Repository Charter at $FILENAME"
