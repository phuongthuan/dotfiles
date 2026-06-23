---
name: Document
interaction: chat
description: Write documentation for code.
opts:
  alias: doc
  auto_submit: true
  user_prompt: false
  modes:
    - v
  stop_context_insertion: true
---

## user

Please brief how it works and provide documentation in comment code for the following code. Also suggest to have better naming to improve readability.

```${context.filetype}
${context.code}
```
