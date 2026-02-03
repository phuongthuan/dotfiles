local M = {}

local functions = require('core.functions')

M.timer = nil
M.enabled = false
M.check_interval = 240000 -- 4 minutes in milliseconds
M.repo = 'Thinkei/eh-mobile-pro'
M.current_pr = nil
M.pr_template_path = vim.fn.expand('~/p/eh/MY_EH_MOBILE_PRO_PULL_REQUEST_TEMPLATE.md')

-- Get the last commit message for PR title
local function get_last_commit_message()
  local message = vim.trim(vim.fn.system({ 'git', 'log', '-1', '--pretty=%s' }))
  if vim.v.shell_error == 0 and message ~= '' then
    return message
  end
  return nil
end

-- Check if PR already exists for current branch
local function is_pr_exists()
  local result = vim.fn.system({ 'gh', 'pr', 'view', '--json', 'number' })
  return vim.v.shell_error == 0 and result ~= ''
end

-- Get the PR number or current branch
local function get_pr_number()
  local pr_number = vim.trim(vim.fn.system({ 'gh', 'pr', 'view', '--json', 'number', '--jq', '.number' }))

  if vim.v.shell_error == 0 and pr_number ~= '' then
    return pr_number
  end

  return nil
end

-- Get the run ID from PR number
local function get_run_id(pr_number)
  if not pr_number then
    return nil
  end

  -- Get the link for pending "Install dependencies" check
  local cmd = {
    'gh',
    'pr',
    'checks',
    pr_number,
    '--json',
    'name,state,link',
    '--jq',
    '.[] | select(.name == "Install dependencies" and .state == "WAITING") | .link',
  }

  local link = vim.trim(vim.fn.system(cmd))

  if vim.v.shell_error == 0 and link ~= '' then
    -- Extract run_id from URL: https://github.com/org/repo/actions/runs/12345/job/67890 => 12345
    local run_id = link:match('/runs/(%d+)/job')
    if run_id then
      return run_id
    end
  end

  return nil
end

-- Get pending deployments for a run
local function get_pending_deployments(run_id)
  local cmd = {
    'gh',
    'api',
    string.format('repos/%s/actions/runs/%s/pending_deployments', M.repo, run_id),
  }

  local result = vim.fn.system(cmd)

  if vim.v.shell_error == 0 and result ~= '' then
    local ok, pending = pcall(vim.json.decode, result)
    if ok then
      return pending
    end
  end

  return nil
end

-- Approve a deployment
local function approve_deployment(run_id, env_id)
  local json_data =
    string.format('{"environment_ids": [%s], "state": "approved", "comment": "Auto-approved by phuongthuan"}', env_id)
  local temp_file = vim.fn.tempname()

  -- Write JSON to temp file
  local file = io.open(temp_file, 'w')

  if not file then
    vim.notify('Failed to create temp file  ', vim.log.levels.ERROR)
    return false
  end

  file:write(json_data)
  file:close()

  -- Approve using temp file
  local cmd = {
    'gh',
    'api',
    '--method',
    'POST',
    string.format('repos/%s/actions/runs/%s/pending_deployments', M.repo, run_id),
    '--input',
    temp_file,
  }

  local result = vim.fn.system(cmd)
  vim.fn.delete(temp_file)

  if vim.v.shell_error == 0 then
    vim.notify(string.format('Approved deployment 󰸞 ', run_id), vim.log.levels.INFO)
    M.stop()
    return true
  else
    vim.notify(string.format('Failed to approve: %s  ', result), vim.log.levels.ERROR)
    return false
  end
end

local function check_pending_deployments()
  local pr_number = get_pr_number()

  if not pr_number then
    vim.notify('No pr_number found  ', vim.log.levels.WARN)
    return
  end

  local run_id = get_run_id(pr_number)

  if not run_id then
    vim.notify('No run_id found  ', vim.log.levels.WARN)
    return
  end

  local pending = get_pending_deployments(run_id)

  if not pending or #pending == 0 then
    vim.notify('No approvable pending check found  ', vim.log.levels.WARN)
    return
  end

  print('Pending deployment available 󰸞 ')
end

-- Check for pending deployments and approve if found
local function check_and_approve()
  local pr_number = get_pr_number()

  if not pr_number then
    vim.notify('No pr_number found  ', vim.log.levels.WARN)
    return
  end

  local run_id = get_run_id(pr_number)

  if not run_id then
    vim.notify('No run_id found  ', vim.log.levels.WARN)
    return
  end

  local pending = get_pending_deployments(run_id)

  if not pending or #pending == 0 then
    vim.notify('No approvable pending check found  ', vim.log.levels.WARN)
    return
  end

  -- Check if deployment is pending and can be approved
  for _, deployment in ipairs(pending) do
    if deployment.environment.name == 'Development' and deployment.current_user_can_approve then
      approve_deployment(run_id, deployment.environment.id)
      return
    end
  end
end

-- Start auto-checking
-- function M.start(pr_number)
--   if M.timer and M.enabled then
--     vim.notify('Auto-approval already running', vim.log.levels.WARN)
--     return
--   end
--
--   M.current_pr = pr_number or get_pr_number()
--
--   if not M.current_pr then
--     vim.notify('No PR number found  ', vim.log.levels.ERROR)
--     return
--   end
--
--   M.enabled = true
--   M.timer = vim.loop.new_timer()
--
--   -- Check immediately
--   check_and_approve()
--
--   -- Then check every minute
--   M.timer:start(
--     M.check_interval,
--     M.check_interval,
--     vim.schedule_wrap(function()
--       if M.enabled then
--         check_and_approve()
--       end
--     end)
--   )
--
--   vim.notify(
--     string.format('Started auto-approval for PR #%s (every %ds)', M.current_pr, M.check_interval / 1000),
--     vim.log.levels.INFO
--   )
-- end

-- Create PR with custom template
function M.create_pr_with_custom_template()
  -- Check if PR already exists
  if is_pr_exists() then
    functions.open_github_pr()
    return
  end

  -- Check if template file exists
  if vim.fn.filereadable(M.pr_template_path) == 0 then
    vim.notify('PR template not found: ' .. M.pr_template_path, vim.log.levels.ERROR)
    return
  end

  local title = get_last_commit_message() or 'Draft PR'

  local cmd = {
    'gh',
    'pr',
    'create',
    '--body-file',
    M.pr_template_path,
    '--title',
    title,
    '--draft',
  }

  local result = vim.trim(vim.fn.system(cmd))

  if vim.v.shell_error == 0 and result ~= '' then
    vim.fn.system({ 'open', result })
  else
    vim.notify('Failed to create PR: ' .. result, vim.log.levels.ERROR)
  end
end

-- Stop auto-checking
function M.stop()
  if M.timer then
    M.timer:stop()
    M.timer:close()
    M.timer = nil
  end

  M.enabled = false
  M.current_pr = nil
end

function M.check_and_approve_deployment()
  print('Checking and approving pending deployment 󰔟')
  check_and_approve()
end

function M.check_pending_deployments()
  print('Checking pending deployments 󰔟')
  check_pending_deployments()
end

function M.setup()
  vim.api.nvim_create_user_command('GHAutoApproveStart', function(opts)
    M.start(opts.args ~= '' and opts.args or nil)
  end, { nargs = '?', desc = 'Start auto-approval monitoring' })

  -- vim.api.nvim_create_user_command('GHAutoApproveStop', M.stop, { desc = 'Stop auto-approval monitoring' })

  vim.api.nvim_create_user_command(
    'GHCheckAndApproveDeployment',
    M.check_and_approve_deployment,
    { desc = 'Check and approve pending deployment' }
  )

  vim.api.nvim_create_user_command(
    'GHCheckDeployment',
    M.check_pending_deployments,
    { desc = 'Check for pending deployments' }
  )

  vim.api.nvim_create_user_command(
    'GHCreatePR',
    M.create_pr_with_custom_template,
    { desc = 'Create PR with custom template' }
  )

  -- Neogit: Auto checking and approve deployment after pushed
  vim.api.nvim_create_autocmd('User', {
    pattern = 'NeogitPushComplete',
    callback = function()
      if not functions.is_eh_mobile_pro_repo() then
        return
      end

      print('Auto checking and approving will start in 4 minutes 󰔟')
      vim.defer_fn(function()
        local pr_number = get_pr_number()
        if pr_number then
          vim.notify('Auto checking and approving deployment 󰔟', vim.log.levels.INFO)
          check_and_approve()
        end
      end, 240000) -- 4 minutes
    end,
    desc = 'Auto approving deployment after pushed',
  })

  -- Neogit: Auto create PR with custom template after pushed
  vim.api.nvim_create_autocmd('User', {
    pattern = 'NeogitPushComplete',
    callback = function()
      if not functions.is_eh_mobile_pro_repo() then
        return
      end

      M.create_pr_with_custom_template()
    end,
    desc = 'Auto create PR with custom template after pushed',
  })

  -- Cleanup on exit
  vim.api.nvim_create_autocmd('VimLeavePre', {
    callback = M.stop,
    desc = 'Stop GH auto-approval monitoring on exit',
  })
end

return M
