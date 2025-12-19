# Quickstart

## Installation

```bash
pip install git-kit
```

## Initialization

Navigate to your git repository:

```bash
cd my-project
git-kit init
```

The CLI will ask:
1.  **Which AI do you use?** (e.g. Claude, Gemini)
2.  **Which Shell?** (Bash or PowerShell)

It will then download the optimized templates and scripts for your setup.

## Your First PR Plan

1.  Run the command:
    ```bash
    git-kit pr "Add Login Feature"
    ```
2.  Edit the generated file in `.github/pr-plans/add-login-feature.md`.
3.  Instruct your AI Agent:
    > "Read .github/pr-plans/add-login-feature.md and implement the changes."

## Checking Status

```bash
git-kit status
```
This shows you all active plans and designs.
