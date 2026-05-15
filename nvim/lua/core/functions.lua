local M = {}

local org = os.getenv('EH_ORG')
local repo = os.getenv('EH_MOBILE_PRO_REPO')
local user = os.getenv('GITHUB_USERNAME')

local function get_absolute_path_current_working_directory()
  return vim.api.nvim_buf_get_name(0)
end

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
  else
    vim.fn.system({ 'open', pr_list_url })
    vim.notify('No PR found!, opening PR list ...', vim.log.levels.WARN)
  end
end

function M.open_github_author_pr_list(project, author)
  local default_project = os.getenv('EH_DEFAULT_PROJECT') or 'eh-mobile-pro'
  local default_author = os.getenv('GITHUB_USERNAME')

  -- Common EH projects
  local projects = {
    'eh-mobile-pro',
    'employment-hero',
    'application-infrastructure',
    'frontend-core',
    'ebf-swag-personal',
  }

  -- If called without arguments, show interactive pickers
  if not project and not author then
    -- Prompt for project
    vim.ui.select(projects, {
      prompt = 'Select project:',
      format_item = function(item)
        return item == default_project and item .. ' (default)' or item
      end,
    }, function(selected_project)
      if not selected_project then
        return
      end

      -- Prompt for author
      vim.ui.input({
        prompt = 'Enter author username (leave empty for default): ',
        default = '',
      }, function(input_author)
        if input_author == nil then
          return -- User cancelled
        end

        local target_project = selected_project
        local target_author = input_author ~= '' and input_author or default_author

        local url = string.format('https://github.com/thinkei/%s/pulls/%s', target_project, target_author)
        vim.fn.system({ 'open', url })
      end)
    end)
  else
    -- Use provided values or defaults (for programmatic calls)
    local target_project = project and project ~= '' and project or default_project
    local target_author = author and author ~= '' and author or default_author

    local url = string.format('https://github.com/thinkei/%s/pulls/%s', target_project, target_author)

    vim.fn.system({ 'open', url })
  end
end

function M.open_github_workflow(workflow_file)
  local url
  if workflow_file then
    -- Open specific workflow file
    url = string.format('https://github.com/%s/%s/actions/workflows/%s', 'Thinkei', repo, workflow_file)
  else
    -- Open all workflows filtered by actor
    url = string.format('https://github.com/%s/%s/actions?query=actor%%3A%s', 'Thinkei', repo, user)
  end
  vim.fn.system({ 'open', url })
end

---@param platform 'ios'|'android'
---@return function
function M.trigger_build_maestro_e2e_test(platform)
  local workflow_files = {
    ios = 'build_maestro_ios_e2e.yml',
    android = 'build_maestro_e2e.yml',
  }

  return function()
    local branch = get_current_branch()
    local workflow_file = workflow_files[platform]

    if vim.v.shell_error ~= 0 then
      vim.notify('Failed to get current branch', vim.log.levels.ERROR)
      return
    end

    local cmd = {
      'gh',
      'workflow',
      'run',
      workflow_file,
      '--ref',
      branch,
    }

    print(string.format(' Triggering build Maestro E2E %s for branch=%s', platform:upper(), branch))

    local result = vim.fn.system(cmd)
    if vim.v.shell_error == 0 then
      vim.notify('Workflow triggered successfully 󰸞 ', vim.log.levels.INFO)
      M.open_github_workflow(workflow_file)
    else
      vim.notify('Failed to trigger workflow: ' .. result, vim.log.levels.ERROR)
    end
  end
end

---@param platform 'ios'|'android'
---@return function
function M.trigger_run_maestro_e2e_test(platform)
  local workflow_files = {
    ios = 'run_maestro_ios_hr_workzone.yml',
    android = 'run_maestro_android_hr_workzone.yml',
  }

  return function()
    local current_branch = get_current_branch()
    local workflow_file = workflow_files[platform]

    if vim.v.shell_error ~= 0 then
      vim.notify('Failed to get current branch', vim.log.levels.ERROR)
      return
    end

    -- Prompt for maestro branch
    local selected_build_branch =
      vim.fn.confirm('Download latest build from branch:', '1 development\n2 current\n3 master', 1)
    local branch_map = { 'development', current_branch, 'master' }
    local build_branch = branch_map[selected_build_branch]

    local cmd = {
      'gh',
      'workflow',
      'run',
      workflow_file,
      '--ref',
      current_branch,
      '--field',
      'maestro_build_branch=' .. build_branch,
    }

    local result = vim.fn.system(cmd)
    if vim.v.shell_error == 0 then
      M.open_github_workflow(workflow_file)
    else
      vim.notify('Failed to trigger workflow: ' .. result, vim.log.levels.ERROR)
    end
  end
end

function M.trigger_expo_build()
  local branch = get_current_branch()

  if vim.v.shell_error ~= 0 then
    vim.notify('Failed to get current branch', vim.log.levels.ERROR)
    return
  end

  -- Prompt for platform
  local platform_choice = vim.fn.confirm('Select platform:', '1 iOS\n2 Android\n3 All', 1)
  local platform_map = { 'ios', 'android', 'all' }
  local platform = platform_map[platform_choice]

  if not platform then
    return
  end

  -- Prompt for profile
  local profile_choice = vim.fn.confirm('Select profile:', '1 Staging\n2 Production', 1)
  local profile_map = { 'staging', 'production' }
  local profile = profile_map[profile_choice]

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

  print(string.format('Triggering build: platform=%s, profile=%s, branch=%s', platform, profile, branch))

  local result = vim.fn.system(cmd)
  if vim.v.shell_error == 0 then
    vim.notify('Workflow triggered successfully 󰸞 ', vim.log.levels.INFO)
  else
    vim.notify('Failed to trigger workflow: ' .. result, vim.log.levels.ERROR)
  end
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

--- Checkout current buffer from a specific branch
--- Useful for discarding local changes and getting a clean version from another branch
---@param branch string|nil Branch name (if nil, prompts user to select)
function M.checkout_from_branch(branch)
  local filepath = get_relative_path_current_buffer()

  if filepath == '' then
    vim.notify('No file in current buffer', vim.log.levels.WARN)
    return
  end

  -- If no branch provided, prompt user to select
  if not branch then
    local branches = { 'development', 'master', 'main' }
    vim.ui.select(branches, {
      prompt = 'Select branch to checkout from:',
    }, function(selected_branch)
      if not selected_branch then
        return
      end

      M.checkout_from_branch(selected_branch)
    end)
    return
  end

  local cmd = { 'git', 'checkout', branch, '--', filepath }
  local result = vim.fn.system(cmd)

  if vim.v.shell_error == 0 then
    vim.cmd('edit!') -- Reload buffer
  else
    vim.notify('Failed to checkout from ' .. branch .. ': ' .. result, vim.log.levels.ERROR)
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

-- Check if current working directory is the frontend-core repository
-- Returns true for:
--   - Main repo: ~/p/eh/frontend-core
--   - Any worktree: ~/p/eh/worktree/frontend-core/*
function M.is_eh_frontend_core_repo()
  local current_dir = vim.fn.getcwd()
  local frontend_core_path = os.getenv('EH_REPOSITORY_DIR') .. '/frontend-core'
  local worktree_base = os.getenv('EH_REPOSITORY_DIR') .. '/worktree/frontend-core'

  -- Check main repo or any path under worktree/frontend-core/
  return current_dir == frontend_core_path or current_dir:find(worktree_base, 1, true) == 1
end

return M
