# Git-Kit Agent Configuration (QWEN)

## Git-Kit Commands (YAML Format)

Qwen prefers commands in YAML format. You can use the following definitions to drive GitHub operations via the scripts in `.github/scripts/`.

```yaml
git-kit:
  commands:
    charter:
      description: "Initialize or update the project charter"
      command: "bash .github/scripts/bash/create-charter.sh"
    design:
      description: "Create a new design document"
      command: "bash .github/scripts/bash/create-design.sh"
    pr:
      description: "Plan a new Pull Request"
      command: "bash .github/scripts/bash/create-pr.sh"
    release:
      description: "Plan a new release"
      command: "bash .github/scripts/bash/create-release.sh"
```

## Methodology
1.  **Plan First**: Never write code/workflows without a plan. Use the `pr` or `design` commands.
2.  **Standards**: Adhere to rules defined in `.github/CHARTER.md`.
3.  **Review**: Always perform a retro after a release.
