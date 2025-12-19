#!/bin/bash
set -euo pipefail

VERSION="$1"

if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN not set" >&2
    exit 1
fi

echo "Ensuring fresh GitHub Release $VERSION..."
# Delete existing release (if any) to allow overwriting
gh release delete "$VERSION" --yes || true

echo "Creating GitHub Release $VERSION..."
# Upload both python artifacts (dist/) and agent zips (dist-release/)
gh release create "$VERSION" dist/* dist-release/* --generate-notes --title "Git-Kit $VERSION"

