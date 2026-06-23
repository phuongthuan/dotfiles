---
name: Naming
interaction: inline
description: Give better naming for the provided code snippet.
opts:
  alias: naming
  auto_submit: true
  user_prompt: false
  modes:
    - v
  stop_context_insertion: true
---

## user

Please provide better names for the following variables and functions:

```${context.filetype}
${context.code}
```
