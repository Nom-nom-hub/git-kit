#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"
NAME="$1"
if [ -z "$NAME" ]; then
    log_warn "Usage: $0 \"Workflow Name\""
    log_info "Defaulting to 'Custom Workflow'"
    NAME="Custom Workflow"
fi
check_root
SLUG=$(echo "$NAME" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g')
FILENAME=".github/workflows/designs/${SLUG}.md"
TEMPLATE=".github/templates/workflow.md"
mkdir -p ".github/workflows/designs"
if [ ! -f "$TEMPLATE" ]; then
    log_error "Template $TEMPLATE not found."
    exit 1
fi
cp "$TEMPLATE" "$FILENAME"
sed -i "s/\[Workflow Name\]/$NAME/g" "$FILENAME" 2>/dev/null || sed -i "" "s/\[Workflow Name\]/$NAME/g" "$FILENAME"
log_success "Created Workflow Design at $FILENAME"
