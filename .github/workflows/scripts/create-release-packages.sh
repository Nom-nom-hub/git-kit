#!/bin/bash
set -euo pipefail

# Usage: ./create-release-packages.sh v1.0.0

VERSION="$1"
if [ -z "$VERSION" ]; then
    echo "Usage: $0 <version>"
    exit 1
fi

AGENTS=("claude" "gemini" "copilot" "cursor" "qwen" "opencode" "codex" "windsurf" "kilocode" "auggie" "roo" "codebuddy" "qoder" "q" "amp" "shai" "bob")
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
        
        # 1. Copy Templates into .github/templates
        mkdir -p "$PKG_DIR/git-kit/.github/templates"
        cp -r "$TEMPLATES_DIR"/*.md "$PKG_DIR/git-kit/.github/templates/"
        
        # 2. Copy Scripts into .github/scripts (Select variant)
        SCRIPTS_DEST="$PKG_DIR/git-kit/.github/scripts"
        mkdir -p "$SCRIPTS_DEST"
        if [ "$VARIANT" == "sh" ]; then
            cp -r "${SCRIPTS_DIR}/bash" "$SCRIPTS_DEST/"
            SCRIPT_EXT="sh"
            SHELL_CMD="bash"
            SCRIPT_PATH_PREFIX=".github/scripts/bash"
        else
            cp -r "${SCRIPTS_DIR}/powershell" "$SCRIPTS_DEST/"
            SCRIPT_EXT="ps1"
            SHELL_CMD="powershell -File"
            SCRIPT_PATH_PREFIX=".github/scripts/powershell"
        fi
        
        # 3. Create Agent Configuration (Split Commands)
        AGENT_DIR=""
        AGENT_FORMAT="md"
        
        case $AGENT in
            "claude")    AGENT_DIR=".claude/commands" ;;
            "gemini")    AGENT_DIR=".gemini/commands"; AGENT_FORMAT="toml" ;;
            "copilot")   AGENT_DIR=".github/agents" ;;
            "cursor")    AGENT_DIR=".cursor/commands" ;;
            "qwen")      AGENT_DIR=".qwen/commands"; AGENT_FORMAT="toml" ;;
            "opencode")  AGENT_DIR=".opencode/command" ;;
            "codex")     AGENT_DIR=".codex/commands" ;;
            "windsurf")  AGENT_DIR=".windsurf/workflows" ;;
            "kilocode")  AGENT_DIR=".kilocode/rules" ;;
            "auggie")    AGENT_DIR=".augment/rules" ;;
            "roo")       AGENT_DIR=".roo/rules" ;;
            "codebuddy") AGENT_DIR=".codebuddy/commands" ;;
            "qoder")     AGENT_DIR=".qoder/commands" ;;
            "q")         AGENT_DIR=".amazonq/prompts" ;;
            "amp")       AGENT_DIR=".agents/commands" ;;
            "shai")      AGENT_DIR=".shai/commands" ;;
            "bob")       AGENT_DIR=".bob/commands" ;;
        esac
        
        FULL_AGENT_DIR="${PKG_DIR}/${AGENT_DIR}"
        mkdir -p "$FULL_AGENT_DIR"
        
        # Defined commands
        CMDS=("charter" "design" "pr" "workflow" "release" "notes" "retro")
        DESCS=(
            "Initialize or update the project charter"
            "Create a new design document"
            "Plan a new Pull Request"
            "Plan a new methodology workflow"
            "Plan a new release"
            "Create release notes"
            "Create a retrospective"
        )
        
        for i in "${!CMDS[@]}"; do
            CMD="${CMDS[$i]}"
            DESC="${DESCS[$i]}"
            
            if [ "$AGENT_FORMAT" == "toml" ]; then
                FILE="${FULL_AGENT_DIR}/${CMD}.toml"
                cat > "$FILE" <<EOF
[git-kit.${CMD}]
description = "${DESC}"
command = "${SHELL_CMD} ${SCRIPT_PATH_PREFIX}/create-${CMD}.${SCRIPT_EXT}"
EOF
            else
                FILE="${FULL_AGENT_DIR}/${CMD}.md"
                cat > "$FILE" <<EOF
# ${AGENT^^} Command: ${CMD}
${DESC}

Command: \`${SHELL_CMD} ${SCRIPT_PATH_PREFIX}/create-${CMD}.${SCRIPT_EXT}\`
EOF
            fi
        done
        
        # 4. Zip it
        (cd "$DIST_DIR" && zip -r "${PKG_NAME}.zip" "${PKG_NAME}/" > /dev/null)
        
        # Cleanup temp dir
        rm -rf "$PKG_DIR"
    done
done

echo "Packages created in $DIST_DIR:"
ls -lh "$DIST_DIR"/*.zip
