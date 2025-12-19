#!/bin/bash
set -e
source "$(dirname "$0")/common.sh"

VERSION="$1"
if [ -z "$VERSION" ]; then
    log_error "Usage: $0 \"vX.Y.Z\""
    exit 1
fi

check_root

FILENAME=".github/releases/${VERSION}.md"
TEMPLATE=".github/release-plan.md"

if [ -f "$FILENAME" ]; then
    log_warn "Plan $FILENAME already exists."
    exit 0
fi

if [ ! -f "$TEMPLATE" ]; then
    log_error "Template $TEMPLATE not found. Run 'git-kit init'."
    exit 1
fi

cp "$TEMPLATE" "$FILENAME"
# Replace placeholders
if [[ "$OSTYPE" == "darwin"* ]]; then
     sed -i '' "s/\[VERSION\]/$VERSION/g" "$FILENAME"
else
     sed -i "s/\[VERSION\]/$VERSION/g" "$FILENAME"
fi

log_success "Created Release Plan at $FILENAME"
