# Git-Kit Agent Configuration

Copy this into your `CLAUDE.md`, `CURSOR.md`, or custom agent instructions.

## Git-Kit Commands (The GitHub Boss)

The user may invoke these commands to drive GitHub operations. Agents should execute the corresponding script found in `.github/scripts/`.

- **`/gitkit.charter`**: `bash .github/scripts/bash/create-charter.sh` (or `.ps1`)
- **`/gitkit.design`**: `bash .github/scripts/bash/create-design.sh`
- **`/gitkit.pr`**: `bash .github/scripts/bash/create-pr.sh`
- **`/gitkit.release`**: `bash .github/scripts/bash/create-release.sh`

## Methodology
1.  **Plan First**: Never write code/workflows without a plan. Use `/gitkit.pr` or `/gitkit.workflow`.
2.  **Standards**: Adhere to rules defined in `.github/CHARTER.md`.
3.  **Review**: Always perform a retro after a release.

