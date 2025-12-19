#!/bin/bash
set -euo pipefail

# Read version from pyproject.toml
if [ -f "pyproject.toml" ]; then
    VERSION=$(grep -oP 'version\s*=\s*"\K[^"]+' pyproject.toml || echo "0.0.0")
else
    echo "Error: pyproject.toml not found" >&2
    exit 1
fi

NEW_VERSION="v$VERSION"
echo "new_version=$NEW_VERSION" >> "$GITHUB_OUTPUT"
echo "Found version: $NEW_VERSION"
