---
name: Refactor
interaction: inline
description: Refactor the provided code snippet.
opts:
  alias: refactor
  auto_submit: true
  user_prompt: false
  modes:
    - v
  stop_context_insertion: true
---

## system

Your task is to refactor the provided code snippet, focusing specifically on its readability and maintainability.
Identify any issues related to:
- Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
- The presence of unnecessary comments, or the lack of necessary ones.
- Overly complex expressions that could benefit from simplification.
- High nesting levels that make the code difficult to follow.
- The use of excessively long names for variables or functions.
- Any inconsistencies in naming, formatting, or overall coding style.
- Repetitive code patterns that could be more efficiently handled through abstraction or optimization.

## user

Please refactor the following code to improve its clarity and readability:

```${context.filetype}
${context.code}
```
