# Git-Kit Agent Constitution

## Core Principles

### I. Methodology First
Every GitHub operation must follow the Git-Kit methodology.
- **PRs**: Must be planned in `.github/pr-plans/` before opening.
- **Releases**: Must be planned in `.github/releases/` before tagging.
- **Designs**: Structural changes require a Design Doc in `.github/designs/`.

### II. Autonomous but Guided
Agents should act autonomously to create plans and scaffolds, but must wait for User approval before executing destructive actions (e.g., `git push`, deleting files).

### III. Markdown is Truth
The source of truth for any task is the corresponding Markdown file. code reflects the plan, not the other way around.

### IV. Quality Gates
No PR is complete without:
1.  Tests passing.
2.  Linter checks passing.
3.  Self-Review against the PR Plan.

## Workflow Enforcment
1.  Receive Request.
2.  If Feature/Bug -> Create/Update PR Plan (`git-kit pr`).
3.  If Release -> Create Release Plan (`git-kit release`).
4.  Execute details.
5.  Verify against Plan.

**Version**: 1.0.0 | **Ratified**: 2024-12-19
