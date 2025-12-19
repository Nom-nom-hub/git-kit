# Git-Kit 📦

**The "GitHub Boss" Methodology.**

Git-Kit is a set of **Markdown Templates** designed to drive your GitHub workflow through clear planning and documentation, just like [Goal-Kit](../README.md).

## Philosophy
Don't just write code; **plan your contributions**. Use these templates to guide AI Agents (and humans) through the PR and Workflow lifecycle.

## Installation 🚀

Install the Git-Kit CLI using `uv`:

```bash
uv tool install git+https://github.com/Nom-nom-hub/git-kit.git
```

## The Templates

### 1. `repo-charter.md` (The Constitution)
*The Vision.* Defines **why** the repo exists and **how** we work.
- Use it to set branching standards, merge rules, and code style.

### 2. `design-doc.md` ( The Strategy)
*The Plan.* Use this for complex features or architectural changes.
- Write this *before* you touch code.
- Get approval on the "Strategy" before executing.

### 3. `pr-template.md` (The Execution)
*The Implementation.* This is your standard Pull Request body.
- Links back to the Design Doc.
- Includes a verification plan.

### 4. `release-plan.md` (The Milestones)
*The Checkpoint.* Defines what goes into `v1.0`, `v1.1`, etc.
- Use it to track the checklist for a release.

### 5. `release-notes.md` & `retro-template.md` (The Review)
*The Report.*
- **Release Notes**: What did we ship?
- **Restrospective**: How can we improve next time?

## The Workflow Loop
1.  **Repo Charter** sets the rules.
2.  **Design Doc** proposes a change.
3.  **PR Template** implements the change.
4.  **Release Plan** groups changes into a version.
5.  **Retro** improves the process.

## The Commands (For Agents)

Instruct your AI Agent with these slash commands:

| Command | File Created |
| :--- | :--- |
| **`/gitkit.charter`** | `.github/CHARTER.md` |
| **`/gitkit.design`** | `.github/designs/feature.md` |
| **`/gitkit.pr`** | `.github/pr-plans/branch.md` |
| **`/gitkit.release`** | `.github/releases/vX.Y.Z.md` |
| **`/gitkit.workflow`** | `.github/workflows/designs/action.md` |
| **`/gitkit.notes`** | `.github/releases/notes.md` |
| **`/gitkit.retro`** | `.github/retros/date.md` |

For setup instructions, see [Agent Integration](./AGENTS.md).


