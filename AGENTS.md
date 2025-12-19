# Git-Kit Agent Integration Guide

**For**: [AGENT_NAME] (Claude, Cursor, Copilot, Gemini, etc.)
**Version**: 1.0

---

## What is Git-Kit?

Git-Kit is the "GitHub Boss" methodology. It uses Markdown templates to standardize how we plan and execute GitHub operations (PRs, Releases, Workflows).

## Your Role as an Agent

When a user invokes a `/gitkit.*` command, your job is to:
1.  **Read** the corresponding template from `git-kit/templates/`.
2.  **Ask** the user for context (if not provided).
3.  **Create** a new file in `.github/` filled out with that context.

---

## Git-Kit Commands

### `/gitkit.charter`
**Establish Repo Vision & Rules**
- **Action**: Create `.github/CHARTER.md` from template.
- **Context**: Ask for branching strategy and merge standards.

### `/gitkit.design`
**Plan a Complex Feature (RFC)**
- **Action**: Run `.github/scripts/create-design.sh "Feature Name"`.
- **Output**: Creates `.github/designs/feature-name.md`.
- **Context**: Ask for problem statement and proposed solution.

### `/gitkit.pr`
**Plan a Pull Request**
- **Action**: Run `.github/scripts/create-pr.sh "PR Title"`.
- **Output**: Creates `.github/pr-plans/pr-title.md`.
- **Context**: Ask "What are we changing and why?".

### `/gitkit.release`
**Plan a Release Version**
- **Action**: Run `.github/scripts/create-release.sh "vX.Y.Z"`.
- **Output**: Creates `.github/releases/vX.Y.Z.md`.
- **Context**: Ask for target version and key features.

### `/gitkit.workflow`
**Design a GitHub Action**
- **Action**: Read `git-kit/templates/workflow-design.md`.
- **Output**: Create `.github/workflows/designs/action-name.md`.
- **Context**: Ask "What should this workflow do?".

### `/gitkit.notes`
**Generate Release Notes**
- **Action**: Read `git-kit/templates/release-notes.md`.
- **Output**: Create `.github/releases/notes-vX.Y.Z.md`.
- **Context**: Read git log / merged PRs to populate lists.

### `/gitkit.retro`
**Conduct a Retrospective**
- **Action**: Read `git-kit/templates/retro-template.md`.
- **Output**: Create `.github/retros/date-retro.md`.
- **Context**: Ask "What went well? What didn't?".

---

## Tips for Agents
- **Always be strict**: If the user's input is vague, ask for clarification.
- **Traceability**: Link PR plans back to Design Docs (Strategies).
- **Location**: Store all plans in `.github/` to keep the root clean.
