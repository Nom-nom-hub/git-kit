#!/bin/bash
set -euo pipefail

echo "Building Git-Kit..."
python -m pip install --upgrade pip build
python -m build
echo "Build complete. Artifacts in dist/"
ls -la dist/
