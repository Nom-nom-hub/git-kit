---
description: Design a new GitHub Action or CI/CD workflow.
---

## User Input

```text
$ARGUMENTS
```

## Outline

1. **Initialize Workflow**: Run `.github/scripts/bash/create-workflow.sh "$ARGUMENTS"`.
2. **Path**: Check `.github/workflows/designs/slug.md`.
3. **Design**:
    - Specify **Triggers** (push, pr, schedule).
    - Outline **Jobs & Steps**.
    - Define **Environment Variables & Secrets**.
    - List **Dependencies**.
4. **Update**: Capture the logic in the design doc before writing the `.yml`.

## Guidelines
- Follow the principle of least privilege for tokens.
- Keep workflows modular and reusable.
- Ensure clear error reporting in steps.
