---
description: Generate release notes from merged PRs and commits.
---

## User Input

```text
$ARGUMENTS
```

## Outline

1. **Gather Intel**: Read merged PRs and git log since the last tag.
2. **Draft**: Populate `.github/templates/notes.md` with:
    - 🚀 Highlights
    - 🐛 Bug fixes
    - 🛠️ Internal changes
3. **Output**: Write to `.github/releases/notes-$VERSION.md`.

## Guidelines
- Categorize changes clearly.
- Credit contributors.
- Include a "Breaking Changes" section if applicable.
