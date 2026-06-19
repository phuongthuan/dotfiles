---
name: Generate a Commit Message for Staged
interaction: chat
description: Generate a commit message for staged change
opts:
  alias: staged-commit
  auto_submit: true
  is_slash_cmd: true
---

## user

Write commit message for the change with commitizen convention. Write clear, informative commit messages that explain the 'what' and 'why' behind changes, not just the 'how'.

```diff
${staged_commit.diff}
```
