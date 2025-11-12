# PR Creator Action

This GitHub Action allows you to automatically open Pull Requests between branches using the GitHub CLI (`gh`).  
It is designed as a composite action and can be published to the GitHub Marketplace for easy reuse in any workflow.

---

## Features

- Opens a Pull Request from a source branch to a destination branch with customizable title and body.
- Leverages the official [GitHub CLI](https://cli.github.com/) for robust and secure PR creation.
- Simple integration with any GitHub Actions workflow.

---

## Requirements

- **GitHub CLI (`gh`)**:  
  This action requires the GitHub CLI to be available in the runner environment.  
  All official GitHub-hosted Ubuntu runners (`ubuntu-latest`) already include `gh` by default.

- **Authentication Token**:  
  The action uses the GitHub CLI, which expects an authentication token via the `GH_TOKEN` environment variable.  
  In most cases, you should use the built-in `${{ github.token }}` or `${{ secrets.GITHUB_TOKEN }}` in your workflow step.

  Example:
  ```yaml
  env:
    GH_TOKEN: ${{ github.token }}
  ```

- **Branch Existence**:  
  Ensure that both the source and destination branches exist in the repository before calling the action.

---

## Inputs

| Name           | Required | Description                |
|----------------|----------|----------------------------|
| `title`        | Yes      | Title for the Pull Request |
| `body`         | Yes      | Body/description of the PR |
| `source_branch`| Yes      | The branch to merge from   |
| `dest_branch`  | Yes      | The branch to merge into   |

---

## Usage Example

Below is a complete workflow example that demonstrates how to use this action:

```yaml
name: Test PR Creator Action

on:
  workflow_dispatch:

jobs:
  test-create-pr:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Create PR from feature/test to develop
        uses: ws2git/gh-pr-creator-action@v1
        env:
          GH_TOKEN: ${{ github.token }}
        with:
          title: "Automated PR: feature/test to develop"
          body: "This Pull Request was created automatically using the PR Creator Action."
          source_branch: "feature/test"
          dest_branch: "develop"
```

---

## How it Works

The action calls a shell script (`create-pr.sh`) that uses the GitHub CLI to open a pull request with the provided parameters.  
You can customize the title and body of the PR as needed. The script also ensures the PR is opened from the specified source branch to the destination branch in the current repository.

---

## Notes

- The action does **not** create branches; both branches must already exist.
- If a pull request already exists between the given branches, the GitHub CLI will return an error and the workflow step will fail.
- The default GitHub Actions token has permissions for PR operations within the same repository. For cross-repository PRs or private repos, ensure the token has adequate permissions.
