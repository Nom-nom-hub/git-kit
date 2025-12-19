#!/bin/bash
set -euo pipefail

VERSION="$1"
if [ -z "$VERSION" ]; then
    echo "Usage: $0 <version>"
    exit 1
fi

if git rev-parse "$VERSION" >/dev/null 2>&1; then
    echo "exists=true" >> "$GITHUB_OUTPUT"
    echo "Release $VERSION already exists."
else
    echo "exists=false" >> "$GITHUB_OUTPUT"
    echo "Release $VERSION does not exist. Proceeding."
fi
