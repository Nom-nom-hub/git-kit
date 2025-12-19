---
description: Plan a new Pull Request following the Git-Kit methodology. Ensure all changes are documented before implementation.
handoffs:
  - label: Implement PR
    prompt: "Ready to implement the changes according to the PR plan?"
---

## User Input

```text
$ARGUMENTS
```

## Outline

The text provided is the PR Title and context.

1. **Initialize Plan**: Run `.github/scripts/bash/create-pr.sh "$ARGUMENTS"` (or PowerShell equivalent) to generate the plan file.
2. **Parse Path**: Capture the generated file path from the script output (e.g., `.github/pr-plans/slug.md`).
3. **Analyze Context**: Based on the project and the user's intent:
    - Detail the **Summary** of changes.
    - List technical **Requirements**.
    - Break down into **Concrete Tasks**.
    - Define **Verification Steps**.
4. **Update File**: Fill out the generated markdown file with this detailed plan.
5. **Handoff**: Notify the user that the plan is ready for review or execution.

## Guidelines
- Stay high-level in the summary but specific in the tasks.
- Ensure tasks are actionable for an AI or Human.
- Link to relevant Design Docs if they exist.
