# Supported Agents 🤖

Git-Kit supports a wide range of AI agents and IDEs. When you run `git-kit init`, the CLI creates the appropriate configuration files in the correct directories for your chosen agent.

## Current Supported Agents

| Agent | Directory | Format | CLI Tool | Description |
| :--- | :--- | :--- | :--- | :--- |
| Claude Code | `.claude/commands/` | Markdown | `claude` | Anthropic's Claude Code CLI |
| Gemini CLI | `.gemini/commands/` | TOML | `gemini` | Google's Gemini CLI |
| GitHub Copilot | `.github/agents/` | Markdown | N/A | GitHub Copilot in VS Code |
| Cursor | `.cursor/commands/` | Markdown | `cursor-agent` | Cursor CLI |
| Qwen Code | `.qwen/commands/` | TOML | `qwen` | Alibaba's Qwen Code CLI |
| opencode | `.opencode/command/` | Markdown | `opencode` | opencode CLI |
| Codex CLI | `.codex/commands/` | Markdown | `codex` | Codex CLI |
| Windsurf | `.windsurf/workflows/` | Markdown | N/A | Windsurf IDE workflows |
| Kilo Code | `.kilocode/rules/` | Markdown | N/A | Kilo Code IDE |
| Auggie CLI | `.augment/rules/` | Markdown | `auggie` | Auggie CLI |
| Roo Code | `.roo/rules/` | Markdown | N/A | Roo Code IDE |
| CodeBuddy CLI | `.codebuddy/commands/` | Markdown | `codebuddy` | CodeBuddy CLI |
| Qoder CLI | `.qoder/commands/` | Markdown | `qoder` | Qoder CLI |
| Amazon Q Developer CLI | `.amazonq/prompts/` | Markdown | `q` | Amazon Q Developer CLI |
| Amp | `.agents/commands/` | Markdown | `amp` | Amp CLI |
| SHAI | `.shai/commands/` | Markdown | `shai` | SHAI CLI |
| IBM Bob | `.bob/commands/` | Markdown | N/A | IBM Bob IDE |

## Configuration Formats

### Split Commands (Individual Files)
Instead of a single large configuration file, Git-Kit now provides **individual command files** in your agent's commands directory (e.g., `.claude/commands/pr.md`, `.qwen/commands/design.toml`). 

This allows agents to index and reference each methodology tool independently, significantly improving reliability and discovery.

### Markdown (`.md`)
Agents that support Markdown receive a set of `.md` files, each defining a slash command and its corresponding shell script invocation.

### TOML (`.toml`)
Agents like **Gemini** and **Qwen** use TOML for structured command definitions. Git-Kit automatically generates individual `.toml` command files for these agents.

## Organized Templates
All methodology templates are now stored in `.github/templates/`. The CLI and scripts use these as a source of truth when creating your plans and designs.

## Initialization
To set up an agent:
1.  Run `git-kit init .`
2.  Select your agent from the interactive prompt.
3.  The CLI will install the specific commands in the directory listed above.
