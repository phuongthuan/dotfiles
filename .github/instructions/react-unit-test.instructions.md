---
description:
  'React Native unit testing guidelines for eh-mobile-pro using Jest and
  @testing-library/react-native'
applyTo: 'app/**/*.spec.js, app/**/__tests__/**/*.js'
---

# React Native Unit Testing Instructions

Guidelines for writing unit tests in `eh-mobile-pro` using Jest and
@testing-library/react-native.

## General Rules

- Test files use JavaScript (`.spec.js`), never TypeScript
- Always use `screen` from `@testing-library/react-native` for queries
- Use custom render utilities that wrap Redux and Hero Design
- Clear mocks in `beforeEach` to ensure test isolation
- Consider `setup` functions for complex test files

## Test File Location

Test files are located in `__tests__` directories adjacent to the source files.

| Source File                              | Test File                                              |
| ---------------------------------------- | ------------------------------------------------------ |
| `app/components/TestComponent.tsx`       | `app/components/__tests__/TestComponent.spec.js`       |
| `app/components/testComponent/index.tsx` | `app/components/testComponent/__tests__/index.spec.js` |
| `app/hooks/useGetData.tsx`               | `app/hooks/__tests__/useGetData.spec.js`               |
| `app/utils/getUserInfo.ts`               | `app/utils/__tests__/getUserInfo.spec.js`              |

## Render Utilities

Use custom render utilities that wrap Redux, Hero Design, and redux-intl.

### Rendering Components

```javascript
import { screen } from '@testing-library/react-native';
import renderWithRedux from '../../../testUtils/renderWithRedux';
import TestComponent from '..';

describe('TestComponent', () => {
  it('should render correctly', () => {
    renderWithRedux(<TestComponent />);

    expect(screen.getByText('Hello World!!')).toBeVisible();
  });
});
```

### Rendering Hooks

```javascript
import renderHookWithRedux from '../../../testUtils/renderHookWithRedux';
import { useCustomHook } from '../useCustomHook';

describe('useCustomHook', () => {
  it('should return correct value', () => {
    const { result } = renderHookWithRedux(() => useCustomHook());

    expect(result.current.value).toBe('expected');
  });
});
```

## Setup Functions

Use setup functions for complex test files with multiple configurations:

```javascript
import { screen } from '@testing-library/react-native';
import renderHookWithRedux from '../../../../testUtils/renderHookWithRedux';
import { useGetCareerSearchPhrases } from '../useGetCareerSearchPhrases';
import { usePillarPermissions } from '../../../hooks/usePillarPermissions';

jest.unmock('react-redux');

jest.mock('../../../hooks/usePillarPermissions');

jest.mock('@ehrocks/ats-mobile', () => ({
  useGetTabsPermissions: jest.fn(),
}));

describe('useGetCareerSearchPhrases', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  const setup = ({ jobTabsPermissions, internalJobPermission } = {}) => {
    useGetTabsPermissions.mockReturnValue({ permissions: jobTabsPermissions });
    usePillarPermissions.mockReturnValue({ internalJobPermission });

    return renderHookWithRedux(() => useGetCareerSearchPhrases());
  };

  it('should return search phrases with correct structure', () => {
    const { result } = setup({
      jobTabsPermissions: { canAccessReferralList: true },
    });

    expect(result.current).toHaveLength(3);
  });
});
```

## Mocking Patterns

### Mock React Navigation

```javascript
import { useRoute, useNavigation } from '@react-navigation/native';
import { screen } from '@testing-library/react-native';
import renderWithRedux from '../../../testUtils/renderWithRedux';
import NavigateButton from '../NavigateButton';

jest.mock('@react-navigation/native', () => ({
  ...jest.requireActual('@react-navigation/native'),
  useRoute: jest.fn(),
  useNavigation: jest.fn(),
}));

const mockNavigation = {
  navigate: jest.fn(),
  goBack: jest.fn(),
};

describe('NavigateButton', () => {
  beforeEach(() => {
    jest.clearAllMocks();
    useNavigation.mockReturnValue(mockNavigation);
    useRoute.mockReturnValue({
      params: { id: 1234 },
    });
  });

  it('should navigate on press', () => {
    renderWithRedux(<NavigateButton />);

    // test implementation
  });
});
```

### Mock Redux Selectors

```javascript
import { screen } from '@testing-library/react-native';
import renderWithRedux from '../../../testUtils/renderWithRedux';
import { featureFlagSelector } from '../../../../loginV2/state';
import MyComponent from '../MyComponent';

jest.mock('../../../../loginV2/state', () => ({
  ...jest.requireActual('../../../../loginV2/state'),
  featureFlagSelector: jest.fn(),
}));

describe('MyComponent', () => {
  beforeEach(() => {
    jest.clearAllMocks();
    featureFlagSelector.mockReturnValue(true);
  });

  it('should render when feature flag is enabled', () => {
    renderWithRedux(<MyComponent />);

    expect(screen.getByText('Feature Content')).toBeVisible();
  });
});
```

### Mock Default Export Component

```javascript
jest.mock('../components/ChildComponent', () => {
  const { Text } = require('react-native');
  return {
    __esModule: true,
    default: () => <Text>Mocked Child</Text>,
  };
});
```

### Mock Default Export Hook

```javascript
import useApproveTimesheet from '../../../useApproveTimesheet';

jest.mock('../../../useApproveTimesheet', () => ({
  __esModule: true,
  default: jest.fn(() => ({
    mutate: jest.fn(),
    isLoading: false,
  })),
}));

describe('Component using hook', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('should call mutate on submit', () => {
    const mockMutate = jest.fn();
    useApproveTimesheet.mockReturnValue({
      mutate: mockMutate,
      isLoading: false,
    });

    // test implementation
  });
});
```

## Testing Redux State

### Test Action Creators and Reducers

```javascript
import {
  REDUCER_PATH,
  TASKS_WIDGET_TAB,
  selectedTasksWidgetTabSelector,
  setSelectedTasksWidgetTabAC,
  selectedTasksWidgetTabReducer,
} from '../state';

describe('selectedTasksWidgetTabReducer', () => {
  it('should return correct default state', () => {
    const initialState = undefined;
    const action = {};

    expect(selectedTasksWidgetTabReducer(initialState, action)).toBe(
      TASKS_WIDGET_TAB.TEAM,
    );
  });

  it('should handle SET_SELECTED_TASKS_WIDGET_TAB action', () => {
    const initialState = TASKS_WIDGET_TAB.TEAM;
    const action = setSelectedTasksWidgetTabAC(TASKS_WIDGET_TAB.PERSONAL);

    expect(selectedTasksWidgetTabReducer(initialState, action)).toBe(
      TASKS_WIDGET_TAB.PERSONAL,
    );
  });
});

describe('selectedTasksWidgetTabSelector', () => {
  it('should return correct value', () => {
    const state = {
      [REDUCER_PATH]: {
        selectedTasksWidgetTab: TASKS_WIDGET_TAB.PERSONAL,
      },
    };

    expect(selectedTasksWidgetTabSelector(state)).toBe(
      TASKS_WIDGET_TAB.PERSONAL,
    );
  });
});
```

## Using it.each

Use `it.each` for functions with multiple test cases (3+ cases):

```javascript
import moment from 'moment';
import { isOverOneDay } from '../dateUtils';

describe('isOverOneDay', () => {
  it.each`
    timestamp                             | expectedResult
    ${moment().add(2, 'days').format()}   | ${true}
    ${moment().add(25, 'hours').format()} | ${true}
    ${moment().add(1, 'days').format()}   | ${false}
    ${moment().add(24, 'hours').format()} | ${false}
    ${null}                               | ${true}
    ${undefined}                          | ${true}
    ${''}                                 | ${true}
  `(
    'returns $expectedResult when timestamp is $timestamp',
    ({ timestamp, expectedResult }) => {
      expect(isOverOneDay(timestamp)).toEqual(expectedResult);
    },
  );
});
```

## Best Practices

### DO ✅

- Use `screen` from `@testing-library/react-native` for all queries
- Use `renderWithRedux` for components and `renderHookWithRedux` for hooks
- Clear mocks in `beforeEach` with `jest.clearAllMocks()`
- Use setup functions for complex test configurations
- Use `it.each` for testing multiple cases (3+ scenarios)
- Mock navigation hooks when component uses `useRoute` or `useNavigation`
- Use `jest.requireActual` to preserve non-mocked exports
- Use `require()` inside mock factories for React Native components

### DON'T ❌

- Use TypeScript in `.spec.js` files
- Import `render` directly from `@testing-library/react-native`
- Forget to mock `useRoute` and `useNavigation` when used in components
- Use `import` statements inside `jest.mock` factories (use `require`)
- Mock `redux-intl`'s `Intl` - it works automatically

## Ignored Implementations

These features work automatically and don't need mocking:

```javascript
// No need to mock - works with renderWithRedux
import { Intl } from 'redux-intl';
```

## Common Queries

| Query                        | Use Case                                      |
| ---------------------------- | --------------------------------------------- |
| `screen.getByText('text')`   | Find element by visible text                  |
| `screen.getByTestId('id')`   | Find element by testID prop                   |
| `screen.getByRole('button')` | Find element by accessibility role            |
| `screen.queryByText('text')` | Check if element exists (returns null if not) |
| `screen.findByText('text')`  | Async query for elements that appear later    |

## Running Tests

```bash
# Run all tests
yarn test

# Run tests for specific file
yarn test app/components/__tests__/MyComponent.spec.js

# Run tests matching pattern
yarn test --testPathPattern="tasksWidget"

# Run with coverage
yarn test --coverage

# Run in watch mode
yarn test --watch
```
