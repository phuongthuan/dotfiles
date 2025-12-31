---
name: Generate Unit Tests
interaction: chat
description: Generate unit tests for eh-mobile-pro
opts:
  alias: ut
  auto_submit: false
  autoload: eh_unit_tests
  modes:
    - n
  adapter:
    name: copilot
    model: claude-sonet-4.5
  stop_context_insertion: true
context:
  - type: file
    path:
      - app/components/testUtils/renderWithRedux.tsx
---

## user

You must follow all rules and conventions that were declared in the given
contexts above. Use @{files} tool to insert, edit, and search for relevant code
in current repo.
