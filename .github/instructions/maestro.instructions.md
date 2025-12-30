---
description: 'Maestro E2E testing guidelines for EH Mobile Pro React Native application'
applyTo: 'maestro/**/*.yml, maestro/**/*.js'
---

# Maestro E2E Testing Instructions

Guidelines for writing end-to-end tests using Maestro for the EH Mobile Pro React Native application.

## Project Structure

```
maestro/
├── config.yml                    # Test execution configuration
├── smoke_test.yml                # Main smoke test entry point
├── smoke_test_*.yml              # Feature-specific smoke tests
├── attachment.jpg                # Test attachment asset
├── common/                       # Shared reusable flows
│   ├── authenticate.yml          # Login flow with env switching
│   ├── clear_state.yml           # App state clearing
│   ├── launch_app.yml            # Platform-specific app launch
│   ├── pin_input.yml             # PIN entry flow
│   ├── restart_app.yml           # App restart flow
│   ├── set_date_picker_native.yml    # iOS native date picker
│   ├── set_hour_minute_am_pm_native.yml  # iOS native time picker
│   └── go_to_*.yml               # Navigation helpers
├── workzone/                     # Workzone domain tests
│   ├── setup/shared_utils.js     # Workzone shared utilities
│   ├── leave/                    # Leave management tests
│   ├── timesheets/               # Timesheet tests
│   └── unavailability/           # Unavailability tests
├── prepayroll/                   # Prepayroll domain tests (TBD)
└── swag/                         # Swag domain tests (TBD)
```

## App Configuration

### App IDs

| Platform | App ID |
|----------|--------|
| Android | `com.ehlife.preview` |
| iOS | `com.employmentheropro.mobile.staging` |

### Environment Variables

All environment variables must use the `MAESTRO_` prefix.

| Variable | Domain | Description |
|----------|--------|-------------|
| `MAESTRO_PREPAYROLL_EMAIL` | prepayroll | Test user email |
| `MAESTRO_PREPAYROLL_PASSWORD` | prepayroll | Test user password |
| `MAESTRO_PREPAYROLL_ADMIN_EMAIL` | prepayroll | Admin user email |
| `MAESTRO_E2E_WORKZONE_TEST_USERNAME_1` | workzone | Workzone test user email |
| `MAESTRO_E2E_WORKZONE_TEST_PASSWORD_1` | workzone | Workzone test user password |
| `MAESTRO_KP_API_KEY` | workzone | KeyPay API key for workzone tests |

## Test Domains

The project has three independent test domains:

| Domain | Directory | Status | Description |
|--------|-----------|--------|-------------|
| workzone | `maestro/workzone/` | ✅ Active | Workzone employee features (leave, timesheets, unavailability) |
| prepayroll | `maestro/prepayroll/` | 🚧 Planned | Prepayroll HR features |
| swag | `maestro/swag/` | 🚧 Planned | Swag/benefits features |

## Code Style

### Inline Formatting

Always use inline format for simple commands:

````yaml
# ✅ GOOD - Inline format
- tapOn: 'Submit'
- assertVisible: 'Welcome'
- waitForAnimationToEnd

# ❌ BAD - Expanded format for simple commands
- tapOn:
    text: 'Submit'
- assertVisible:
    text: 'Welcome'
````

Use expanded format only when additional properties are needed:

````yaml
# ✅ GOOD - Expanded format when properties are required
- tapOn:
    id: 'submit-button'
    retryTapIfNoChange: true

- assertVisible:
    text: '.*Annual leave.*'
    optional: true

- extendedWaitUntil:
    visible:
      id: 'dashboard-screen'
    timeout: 30000
````

## Test Flow Patterns

### Basic Flow Structure

Every test flow should follow this template:

````yaml
appId: com.ehlife.preview
jsEngine: graaljs
onFlowStart:
  - runScript: ../setup/shared_utils.js
  - runScript: ./setup/<feature>_utils.js
  - runScript:
      file: ./setup/clear_all.js
      env:
        MAESTRO_KP_API_KEY: '${MAESTRO_KP_API_KEY}'
  - runScript:
      file: ./setup/<test_name>.js
      env:
        MAESTRO_KP_API_KEY: '${MAESTRO_KP_API_KEY}'
  - startRecording: maestro_recordings/<domain>_<feature>_<action>
onFlowComplete:
  - runScript:
      file: ./setup/clear_all.js
      env:
        MAESTRO_KP_API_KEY: '${MAESTRO_KP_API_KEY}'
  - stopRecording
tags:
  - <domain>
  - <feature>
---
# Test steps below
````

### Authentication Flows

#### Prepayroll Authentication

````yaml
- runFlow:
    file: ../common/authenticate.yml
    env:
      EMAIL: ${MAESTRO_PREPAYROLL_EMAIL}
      PASSWORD: ${MAESTRO_PREPAYROLL_PASSWORD}
      SWITCH_ENV: payroll
````

#### Workzone Authentication

````yaml
- runFlow:
    file: ../../common/authenticate.yml
    env:
      EMAIL: ${MAESTRO_E2E_WORKZONE_TEST_USERNAME_1}
      PASSWORD: ${MAESTRO_E2E_WORKZONE_TEST_PASSWORD_1}
````

### Cross-Platform Handling

Handle platform differences explicitly:

````yaml
# Platform-specific app launch
- runFlow:
    when:
      platform: Android
    commands:
      - launchApp
      - waitForAnimationToEnd

- runFlow:
    when:
      platform: iOS
    commands:
      - launchApp:
          appId: com.employmentheropro.mobile.staging
          stopApp: true
      - waitForAnimationToEnd

# Platform-specific scrolling
- runFlow:
    when:
      platform: Android
    commands:
      - swipe:
          direction: UP

- runFlow:
    when:
      platform: iOS
    commands:
      - scrollUntilVisible:
          element:
            text: 'Target Element'
````

## Element Selection

### Best Practices

````yaml
# ✅ PREFERRED - Use testID/accessibilityId
- tapOn:
    id: 'request-leave-button'

# ✅ GOOD - Use text with regex for flexibility
- tapOn: '.*Annual leave.*'

# ✅ GOOD - Use positional context
- assertVisible:
    text: ${output.expectedHours}
    rightOf: ${output.expectedDate}

# ✅ GOOD - Use index for multiple matches
- tapOn:
    id: 'selected-date-cell'
    index: 0
````

## Waiting and Timing

````yaml
# ✅ PREFERRED - Wait for specific element
- extendedWaitUntil:
    visible:
      id: 'swag-dashboard-screen'
    timeout: 30000

# ✅ GOOD - Wait for element to disappear
- extendedWaitUntil:
    notVisible:
      id: 'splash-animated'

# ✅ GOOD - Wait for animation completion
- waitForAnimationToEnd

# ⚠️ AVOID - Hard-coded delays (only when absolutely necessary)
- tapOn:
    id: 'text-input-email_input'
    repeat: 2
    delay: 1000
````

## JavaScript Utilities Pattern

### Shared Configuration (shared_utils.js)

````javascript
/**
 * Shared configuration for KeyPay API requests
 */
const KP_SHARED_CONFIG = {
  API_URL: 'https://staging.keypay.dev/api/v2',
  HEADERS: {
    Accept: 'application/json',
    'Accept-Language': 'en-AU',
    'Cache-Control': 'no-store',
    'Content-Type': 'application/json',
    'eh-request-platform': 'mobile',
    'mobile-version': '2.52.4',
  },
};

const KpDateUtils = {
  formatDateForAPI: date => {
    const dateObj = new Date(date);
    const year = dateObj.getFullYear();
    const month = String(dateObj.getMonth() + 1).padStart(2, '0');
    const day = String(dateObj.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  },
  // ... other date utilities
};

// Export for use in other scripts
output.shared = {
  KpDateUtils,
  KP_SHARED_CONFIG,
};
````

### Feature Utilities (leave_utils.js)

````javascript
const { KP_SHARED_CONFIG } = output.shared;

const KP_LEAVE_CONFIG = {
  BUSINESS_ID: '49067',
  EMPLOYEE_ID: '5545065',
  LEAVE_CATEGORY_ID: '307387',
};

const KpLeaveApiUtils = {
  getLeaveRequests: (token, status = 'Pending') => {
    const url = `${KP_SHARED_CONFIG.API_URL}/business/${KP_LEAVE_CONFIG.BUSINESS_ID}/leaverequest`;
    const response = http.get(url, {
      headers: {
        ...KP_SHARED_CONFIG.HEADERS,
        Authorization: `Basic ${token}`,
      },
    });
    return response.ok ? json(response.body) : [];
  },

  deleteLeaveRequest: (token, leaveRequestId) => {
    const url = `${KP_SHARED_CONFIG.API_URL}/business/${KP_LEAVE_CONFIG.BUSINESS_ID}/employee/${KP_LEAVE_CONFIG.EMPLOYEE_ID}/leaverequest/${leaveRequestId}`;
    const response = http.delete(url, {
      headers: {
        ...KP_SHARED_CONFIG.HEADERS,
        Authorization: `Basic ${token}`,
      },
    });
    return response.ok;
  },

  cancelAllLeaveRequests: token => {
    const pendingLeaveRequests = KpLeaveApiUtils.getLeaveRequests(token);
    pendingLeaveRequests.forEach(request => {
      KpLeaveApiUtils.deleteLeaveRequest(token, request.id);
    });
  },
};

// Export for use in other scripts
output.leave = {
  KpLeaveApiUtils,
  KP_LEAVE_CONFIG,
};
````

### Cleanup Script (clear_all.js)

````javascript
const { KpLeaveApiUtils } = output.leave;

KpLeaveApiUtils.cancelAllLeaveRequests(MAESTRO_KP_API_KEY);
````

### Setup Script (create_leave_request.js)

````javascript
const { KpDateUtils } = output.shared;
const { KP_LEAVE_CONFIG, KpLeaveApiUtils } = output.leave;

const token = MAESTRO_KP_API_KEY;
const dateRange = KpDateUtils.generateDateRange(12, 15);
const leaveHours = KpLeaveApiUtils.getLeaveHours(token, dateRange.apiStartDate, dateRange.apiEndDate);

// Export expected values for assertions in test flow
output.leave.expectedLeaveHours = leaveHours;
output.leave.expectedSelectStartMonthYear = KpDateUtils.formatMonthYear(dateRange.startDate);
````

## iOS-Specific Patterns

### Native Date Picker (iOS)

Use the shared flow `maestro/common/set_date_picker_native.yml` for iOS scroll wheel date pickers:

````yaml
- runFlow:
    when:
      platform: iOS
    file: ../../common/set_date_picker_native.yml
    env:
      DAY: '15'
      MONTH: 'January'
      YEAR: '2026'
````

Parameters:
- `DAY`: Day of month (e.g., "15")
- `MONTH`: Full month name (e.g., "January")
- `YEAR`: Four-digit year (e.g., "2026")

### Native Time Picker (iOS)

Use the shared flow `maestro/common/set_hour_minute_am_pm_native.yml` for iOS time pickers:

````yaml
- runFlow:
    when:
      platform: iOS
    file: ../../common/set_hour_minute_am_pm_native.yml
    env:
      HOUR: '8'
      MINUTES: '20'
      AM_PM: 'AM'
````

Parameters:
- `HOUR`: Hour value (e.g., "8")
- `MINUTES`: Minutes value (e.g., "20")
- `AM_PM`: "AM" or "PM"

### Flaky hideKeyboard on iOS

The `hideKeyboard` command can be flaky on iOS. Use this pattern to handle it reliably:

````yaml
- runFlow:
    when:
      platform: iOS
    commands:
      - hideKeyboard
      - tapOn: '.*Contact Number.*'
      - assertVisible:
          text: 'Save'
          label: 'Keyboard hidden successfully on iOS'
    label: 'Handle flaky hide keyboard for iOS'
- waitForAnimationToEnd
````

Key points:
- Tap on another element after `hideKeyboard` to ensure focus changes
- Assert a previously hidden element is visible to verify keyboard is dismissed
- Always add `waitForAnimationToEnd` after the flow

## Common Patterns

### Date Picker Navigation

````yaml
- evalScript: ${output.navigationAttempts = 0}
- repeat:
    while:
      notVisible:
        text: '.*${output.expectedMonthYear}.*'
    commands:
      - evalScript: |
          ${
            if (output.navigationAttempts >= 3) {
              throw new Error('Failed to find target date after 3 navigation attempts');
            }
            output.navigationAttempts++;
          }
      - tapOn:
          id: 'next-icon-button'
      - waitForAnimationToEnd

- tapOn:
    text: '15'
    label: 'Select date 15'
````

### Retry Mechanism

````yaml
- retry:
    maxRetries: 3
    commands:
      - runFlow:
          when:
            visible: 'error condition'
          commands:
            - tapOn: 'retry-button'
      - waitForAnimationToEnd
      - assertVisible:
          id: 'success-screen'
````

### Conditional Flows

````yaml
- runFlow:
    when:
      visible: 'Accept risk'
      platform: Android
    commands:
      - tapOn: 'Accept risk'
      - waitForAnimationToEnd
````

## Test Tagging Strategy

Use tags for test organization and selective execution:

| Tag | Description |
|-----|-------------|
| `smoke-test` | Core functionality tests |
| `workzone` | Workzone domain tests |
| `prepayroll` | Prepayroll domain tests |
| `swag` | Swag domain tests |
| `leave` | Leave feature tests |
| `timesheets` | Timesheet feature tests |

## Best Practices

### DO ✅

- Always include `onFlowStart` setup and `onFlowComplete` cleanup
- Use `jsEngine: graaljs` when running JavaScript
- Handle both iOS and Android platform differences
- Use descriptive labels for complex steps
- Use `extendedWaitUntil` instead of fixed delays
- Export expected values from setup scripts for assertions
- Clean up test data after test completion
- Use regex patterns for flexible text matching
- Use inline format for simple commands
- Prefix all environment variables with `MAESTRO_`

### DON'T ❌

- Hardcode test data in YAML files
- Skip cleanup in `onFlowComplete`
- Assume platform-specific behavior works cross-platform
- Use `sleep` or fixed delays without justification
- Leave debugging `console.log` statements in production
- Create tests without proper setup/teardown
- Use absolute paths for file references
- Use expanded format for simple tapOn/assertVisible commands
- Use environment variables without `MAESTRO_` prefix

## Running Tests

```bash
# Run all tests
maestro test maestro/

# Run specific test
maestro test maestro/workzone/leave/employee_create_leave.yml

# Run tests by tag
maestro test --tags=employee_file maestro/

# Run with environment variables
MAESTRO_E2E_WORKZONE_TEST_USERNAME_1=user@test.com \
MAESTRO_E2E_WORKZONE_TEST_PASSWORD_1=secret \
MAESTRO_KP_API_KEY=api_key \
maestro test maestro/workzone/leave/employee_create_leave.yml
```

## Debugging Tips

- **View recordings**: Check `~/.maestro/recordings/` for video recordings
- **Console output**: Use `console.log()` in JavaScript for debugging
- **API responses**: Log `response.body` before throwing errors
- **Element inspection**: Use Maestro Studio for element discovery
- **Retry flaky steps**: Use `retry` command with `maxRetries`
