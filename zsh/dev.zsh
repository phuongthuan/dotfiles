# Run yarn test with --coverage
ytc() {
  # Check if a test file path was provided
  if [ -z "$1" ]; then
    echo "Error: Please provide the path to the test file."
    echo "Usage: test_coverage <path/to/your/file.spec.js>"
    return 1
  fi

  local TEST_FILE="$1"
  local BASE_NAME

  # 1. Remove the test-specific extension (.spec.js, .test.ts, etc.)
  # The variable ${VAR%%PATTERN} removes the longest matching suffix from VAR.
  if [[ "$TEST_FILE" =~ \.(spec|test)\.(js|ts|jsx|tsx)$ ]]; then
    BASE_NAME="${TEST_FILE%.*}"
    BASE_NAME="${BASE_NAME%.*}"
  else
    echo "Error: Test file must end with .spec.js, .test.ts, or similar."
    return 1
  fi

  # 2. Remove the __tests__ directory from the path
  # The variable ${VAR/PATTERN/REPLACEMENT} substitutes the first match of PATTERN.
  # We replace "__tests__/" with an empty string.
  local SOURCE_PREFIX="$BASE_NAME"
  SOURCE_PREFIX="${SOURCE_PREFIX/__tests__\//}"
  SOURCE_PREFIX="${SOURCE_PREFIX/__test__\//}"
  SOURCE_PREFIX="${SOURCE_PREFIX/\/tests\//}"
  SOURCE_PREFIX="${SOURCE_PREFIX/\/test\//}"

  # 3. Create the glob pattern for the source file extensions
  # This ensures we match .ts, .tsx, or .js for the main source file.
  local SOURCE_GLOB="${SOURCE_PREFIX}.{ts,tsx,js}"

  echo -e "\n\033[32m Running Test File: $TEST_FILE \033[0m"
  echo -e "\033[32m Collecting Coverage From: $SOURCE_GLOB \033[0m\n"

  # Execute the Jest command
  # We use 'sh -c' to ensure the brace expansion {ts,tsx,js} is correctly evaluated by the shell.
  yarn test "$TEST_FILE" --coverage --collectCoverageFrom="$SOURCE_GLOB"

  echo -e "\n\033[32m Running Test File: $TEST_FILE \033[0m"
  echo -e "\033[32m Collecting Coverage From: $SOURCE_GLOB \033[0m\n"
}
# Running Test File: /Users/thuan/p/eh/eh-mobile-pro/app/components/employeeStatus/__test__/utils.spec.js
#  Collecting Coverage From: /Users/thuan/p/eh/eh-mobile-pro/app/components/employeeStatus/utils.{ts,tsx,js}

# Run maestro test with debug output
mte() {
  if [ -z "$1" ]; then
    echo "Error: Please provide the path to the maestro test file."
    echo "Usage: mte <path/to/your/flow.yaml>"
    return 1
  fi

  local TEST_FILE="$1"

  # echo -e "\n\033[32mCleaning Maestro recordings and output... \033[0m"
  # sudo rm -rf maestro_recordings/* maestro_output/*

  echo -e "\033[32mRunning Maestro E2E tests ... \033[0m\n"
  maestro test "$TEST_FILE" --debug-output=maestro_output

  local EXIT_CODE=$?

  if [ $EXIT_CODE -eq 0 ]; then
    echo -e "\n\033[32m ✓ Maestro test completed successfully \033[0m\n"
  else
    echo -e "\n\033[31m ✗ Maestro test failed (exit code: $EXIT_CODE) \033[0m\n"
  fi

  return $EXIT_CODE
}

test_changed_files() {
  local CHANGED_TESTS
  local BASE_BRANCH=${1:-development}

  # Get added/modified test files only
  CHANGED_TESTS=$(git diff --name-only --diff-filter=AM $BASE_BRANCH...HEAD | grep -E '\.(spec|test)\.(ts|tsx|js|jsx)$')

  if [ -z "$CHANGED_TESTS" ]; then
    echo "No test files changed"
    exit 0
  fi

  echo "Running changed tests:"
  echo "$CHANGED_TESTS"

  # Pass files as arguments with -- to indicate end of options
  # Use arrays to handle spaces/special chars properly
  local -a test_files
  while IFS= read -r file; do
    test_files+=("$file")
  done <<<"$CHANGED_TESTS"

  # Run Jest with explicit testPathPattern or pass files directly
  yarn test --testPathPattern="($(printf '%s|' "${test_files[@]}" | sed 's/|$//'))" --no-coverage
}
