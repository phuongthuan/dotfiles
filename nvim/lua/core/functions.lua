local M = {}

local org = os.getenv('EH_ORG')
local repo = os.getenv('EH_MOBILE_PRO_REPO')
local user = os.getenv('GITHUB_USERNAME')

local function get_absolute_path_current_buffer()
  return vim.api.nvim_buf_get_name(0)
end

local function get_relative_path_current_buffer()
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
end

local function get_current_branch()
  return vim.fn.systemlist('git rev-parse --abbrev-ref HEAD')[1]
end

function M.get_pr_number()
  local branch = get_current_branch()
  local pr_number = vim.trim(vim.fn.system({ 'gh', 'pr', 'view', branch, '--json', 'number', '--jq', '.number' }))

  if vim.v.shell_error == 0 and pr_number ~= '' then
    print('get_pr_number: ' .. pr_number)
    return pr_number
  end

  return nil
end

function M.open_my_github()
  vim.fn.system({ 'open', 'https://github.com/phuongthuan' })
end

function M.open_github_pr()
  local branch = get_current_branch()
  local pr_url_id = vim.trim(vim.fn.system({ 'gh', 'pr', 'view', branch, '--json', 'url', '--jq', '.url' }))
  local pr_list_url = string.format('https://github.com/%s/%s/pulls/%s', org, repo, user)

  if vim.v.shell_error == 0 and pr_url_id ~= '' then
    vim.fn.system({ 'open', pr_url_id })
    print('Opening PR ...' .. pr_url_id)
  else
    vim.fn.system({ 'open', pr_list_url })
    vim.notify('No PR found!, opening PR list ...', vim.log.levels.WARN)
  end
end

function M.open_github_workflows()
  local url = string.format('https://github.com/Thinkei/%s/actions?query=actor%%3A%s', repo, user)

  vim.fn.system({ 'open', url })
  print(' Opening GitHub Workflows: ' .. url)
end

--- Trigger GitHub workflow to build app with Expo
function M.trigger_expo_build()
  local branch = get_current_branch()

  if vim.v.shell_error ~= 0 then
    vim.notify('Failed to get current branch', vim.log.levels.ERROR)
    return
  end

  -- Prompt for platform
  vim.ui.select({ 'ios', 'android', 'all' }, {
    prompt = 'Select platform:',
  }, function(platform)
    if not platform then
      return
    end

    -- Prompt for profile
    vim.ui.select({ 'staging', 'production' }, {
      prompt = 'Select profile:',
    }, function(profile)
      if not profile then
        return
      end

      -- Build and execute the command
      local cmd = {
        'gh',
        'workflow',
        'run',
        'build_app_with_expo.yml',
        '--ref',
        branch,
        '--field',
        'platform=' .. platform,
        '--field',
        'profile=' .. profile,
        '--field',
        'should_submit=true',
        '--field',
        'disable_codepush=true',
      }

      print(string.format(' Triggering build: platform=%s, profile=%s, branch=%s', platform, profile, branch))

      local result = vim.fn.system(cmd)
      if vim.v.shell_error == 0 then
        vim.notify('Workflow triggered successfully 󰸞 ', vim.log.levels.INFO)
      else
        vim.notify('Failed to trigger workflow: ' .. result, vim.log.levels.ERROR)
      end
    end)
  end)
end

--- Toggles between component file and test file
--- If in component: opens test file (__tests__/file.spec.js, __test__/file.spec.js, or file.spec.js)
--- If in test: opens component file (.tsx, .ts, .jsx, .js)
function M.toggle_react_test_file()
  local filepath = get_absolute_path_current_buffer()
  local filename = filepath:match('([^/]+)$')
  local dir = filepath:match('(.*/)') or ''

  -- Check if current file is a test file
  local is_test_file = filename:match('%.spec%.') or filename:match('%.test%.')

  if is_test_file then
    -- If in a test file, find the component file
    local test_file_without_ext = filename:gsub('%.spec%..*$', ''):gsub('%.test%..*$', '')
    local parent_dir = dir:gsub('__tests?__/', '')

    -- Try original file extensions in order
    local original_file_extensions = { '.tsx', '.ts', '.jsx', '.js' }

    local original_file
    for _, ext in ipairs(original_file_extensions) do
      local location = parent_dir .. test_file_without_ext .. ext
      if vim.fn.filereadable(location) == 1 then
        original_file = location
        break
      end
    end

    if not original_file then
      vim.notify('Original file not found', vim.log.levels.WARN)
    else
      vim.cmd('edit ' .. original_file)
    end
  else
    -- If in a original file, find the test file
    local test_file_without_ext = filename:gsub('%.[^.]+$', '')

    -- Try test file locations and extensions in order
    local test_dirs = { '__tests__/', '__test__/', '' }
    local test_file_extensions = { '.spec.tsx', '.spec.ts', '.spec.jsx', '.spec.js' }
    local test_locations = {}

    local test_file
    for _, test_dir in ipairs(test_dirs) do
      for _, ext in ipairs(test_file_extensions) do
        local location = dir .. test_dir .. test_file_without_ext .. ext
        table.insert(test_locations, location)
        if vim.fn.filereadable(location) == 1 then
          test_file = location
          break
        end
      end
      if test_file then
        break
      end
    end

    if not test_file then
      vim.notify('Test file not found!', vim.log.levels.WARN)
    else
      vim.cmd('edit ' .. test_file)
    end
  end
end

-- Check if current working directory is the eh-mobile-pro repository
-- Returns true for:
--   - Main repo: ~/p/eh/eh-mobile-pro
--   - Any worktree: ~/p/eh/worktree/eh-mobile-pro/*
function M.is_eh_mobile_pro_repo()
  local current_dir = vim.fn.getcwd()
  local eh_mobile_pro_path = os.getenv('EH_REPOSITORY_DIR') .. '/eh-mobile-pro'
  local worktree_base = os.getenv('EH_REPOSITORY_DIR') .. '/worktree/eh-mobile-pro'

  -- Check main repo or any path under worktree/eh-mobile-pro/
  return current_dir == eh_mobile_pro_path or current_dir:find(worktree_base, 1, true) == 1
end

return M
