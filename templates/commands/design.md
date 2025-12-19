---
description: Create a technical design document for a complex feature or architectural change.
---

## User Input

```text
$ARGUMENTS
```

## Outline

1. **Initialize Design**: Run `.github/scripts/bash/create-design.sh "$ARGUMENTS"` to create the design doc.
2. **Path**: Locate `.github/designs/slug.md`.
3. **Details**:
    - Define the **Problem Statement**.
    - Propose the **Technical Solution**.
    - Discuss **Alternatives Considered**.
    - Outline **Security & Performance** implications.
4. **Update**: Fill the template with deep technical analysis.
5. **Review**: Notify the user for architectural review.

## Guidelines
- Be specific about APIs, Data Models, and Side Effects.
- Use Mermaid diagrams if the logic is complex.
- Focus on maintainability and scalability.
