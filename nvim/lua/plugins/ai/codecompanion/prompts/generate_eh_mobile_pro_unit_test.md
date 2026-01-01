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
    model: claude-sonnet-4.5
  stop_context_insertion: true
---

## user

Follow all React Native unit testing rules and conventions as declared in the provided instructions for eh-mobile-pro. Ensure all generated tests strictly comply with those guidelines.
