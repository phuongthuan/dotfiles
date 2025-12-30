---
name: Inline Document
interaction: inline
description: Add documentation for code.
opts:
  alias: inline-doc
  auto_submit: true
  user_prompt: false
  modes:
    - v
  stop_context_insertion: true
---

## user

Please provide documentation in comment code for the following code and suggest to have better naming to improve readability.

```${context.filetype}
${context.code}
```
