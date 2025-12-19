#!/bin/bash
set -euo pipefail

# Usage: ./create-release-packages.sh v1.0.0

VERSION="$1"
if [ -z "$VERSION" ]; then
    echo "Usage: $0 <version>"
    exit 1
fi

AGENTS=("claude" "gemini" "copilot" "cursor" "qwen" "windsurf" "opencode" "codex" "kilocode" "auggie" "codebuddy" "roo" "q")
VARIANTS=("sh" "ps")

# Directory setup
DIST_DIR="dist-release"
mkdir -p "$DIST_DIR"
TEMPLATES_DIR="./templates"
SCRIPTS_DIR="./scripts"


echo "Creating release packages for $VERSION..."

for AGENT in "${AGENTS[@]}"; do
    for VARIANT in "${VARIANTS[@]}"; do
        echo "Building $AGENT - $VARIANT..."
        
        PKG_NAME="git-kit-template-${AGENT}-${VARIANT}-${VERSION}"
        PKG_DIR="${DIST_DIR}/${PKG_NAME}"
        mkdir -p "$PKG_DIR/git-kit/"
        
        # 1. Copy Templates into .github
        mkdir -p "$PKG_DIR/git-kit/.github"
        cp -r "$TEMPLATES_DIR"/* "$PKG_DIR/git-kit/.github/"
        
        # 2. Copy Scripts into .github/scripts (Select variant)
        SCRIPTS_DEST="$PKG_DIR/git-kit/.github/scripts"
        mkdir -p "$SCRIPTS_DEST"
        if [ "$VARIANT" == "sh" ]; then
            cp -r "${SCRIPTS_DIR}/bash" "$SCRIPTS_DEST/"
        else
            cp -r "${SCRIPTS_DIR}/powershell" "$SCRIPTS_DEST/"
        fi
        
        # 3. Create Agent Instruction File
        # Customize the generic template
        AGENT_FILE="${PKG_DIR}/${AGENT^^}.md" # Default: CLAUDE.md
        
        # Custom filenames
        case $AGENT in
            "copilot") AGENT_FILE="${PKG_DIR}/.github/goal-kit-guide.md" ;; # Copilot often reads .github
            "vscode")  AGENT_FILE="${PKG_DIR}/git-kit-instructions.md" ;;
            *) ;;
        esac
        
        # Ensure dir exists for custom paths
        mkdir -p "$(dirname "$AGENT_FILE")"
        
        sed "s/\[AGENT_NAME\]/${AGENT^^}/g" "$TEMPLATES_DIR/agent-file-template.md" > "$AGENT_FILE"
        
        # 4. Zip it
        (cd "$DIST_DIR" && zip -r "${PKG_NAME}.zip" "${PKG_NAME}/")
        
        # Cleanup temp dir
        rm -rf "$PKG_DIR"
    done
done

echo "Packages created in $DIST_DIR:"
ls -lh "$DIST_DIR"/*.zip
