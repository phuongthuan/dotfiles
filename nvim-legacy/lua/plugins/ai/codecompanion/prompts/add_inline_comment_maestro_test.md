---
name: Review and providing inline comment for Maestro test
interaction: chat
description:
  Review the provided Maestro test case code and add inline comments explaining
  each step's purpose.
opts:
  autoload: maestro_e2e_tests
  modes:
    - n
  adapter:
    name: copilot
    model: claude-sonnet-4.5
  stop_context_insertion: true
---

## user

Your task is review the following Maestro test case code and adding inline
comments to explain the purpose of each step.

1. Reviewing

You must read through the provided Maestro instructions above.

2. Adding comment

Your must following the instructions below:

- Don't add inline comments for `onFlowStart` and `onFlowComplete` sections
- For the assertion with clear text or simple step with clear context, don't add
  label for it, for example:
  ```yml
  - assertVisible: '.*Some clear text.*'
  - assertNotVisible: '.*Some clear text.*'
  ```

Here is the example for how you should comment the steps:

```yml
# Step 1: Authenticate user and navigate to unavailability tab
# Action: Login with test credentials and navigate to unavailability feature
# Expected: User is authenticated and unavailability screen is displayed
- runFlow:
    file: ../common/authenticate_and_navigate_to_unavailability.yml
    env:
      EMAIL: ${MAESTRO_E2E_WORKZONE_TEST_USERNAME_1}
      PASSWORD: ${MAESTRO_E2E_WORKZONE_TEST_PASSWORD_1}

# Step 2: Open unavailability creation form
# Action: Tap on add unavailability button
# Expected: Create unavailability form opens with date picker visible
- tapOn:
    id: add-unavailability-button

- extendedWaitUntil:
    visible:
      id: from-date-picker
```
