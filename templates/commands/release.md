---
description: Plan a new software release. Coordinate versioning, changelogs, and verification.
---

## User Input

```text
$ARGUMENTS
```

## Outline

1. **Initialize Release**: Run `.github/scripts/bash/create-release.sh "$ARGUMENTS"` to create the release plan file.
2. **Path**: Find the file at `.github/releases/$VERSION.md`.
3. **Execution**:
    - Identify all merged PRs since the last release.
    - Summarize key features and bug fixes.
    - Outline the **Release Checklist** (e.g., tagging, CI verification).
4. **Update**: Populate the markdown file with these details.
5. **Report**: Confirm the release plan is ready.

## Guidelines
- Follow SemVer strictly.
- Ensure all major changes have a corresponding PR linked.
- Focus on user-facing impact in the summaries.
