local M = {}

local functions = require('functions')

M.timer = nil
M.enabled = false
M.repo = 'Thinkei/eh-mobile-pro'
M.current_pr = nil
M.pr_template_path = vim.fn.expand('~/p/eh/MY_EH_MOBILE_PRO_PULL_REQUEST_TEMPLATE.md')

local function get_last_commit_message()
  local message = vim.trim(vim.fn.system({ 'git', 'log', '-1', '--pretty=%s' }))
  if vim.v.shell_error == 0 and message ~= '' then
    return message
  end
  return nil
end

local function is_pr_exists()
  local result = vim.fn.system({ 'gh', 'pr', 'view', '--json', 'number' })
  return vim.v.shell_error == 0 and result ~= ''
end

local function get_pr_number()
  local pr_number = vim.trim(vim.fn.system({ 'gh', 'pr', 'view', '--json', 'number', '--jq', '.number' }))
  if vim.v.shell_error == 0 and pr_number ~= '' then
    return pr_number
  end
  return nil
end

local function get_run_id(pr_number)
  if not pr_number then
    return nil
  end

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
    local run_id = link:match('/runs/(%d+)/job')
    if run_id then
      return run_id
    end
  end

  return nil
end

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

local function approve_deployment(run_id, env_id)
  local json_data =
    string.format('{"environment_ids": [%s], "state": "approved", "comment": "Auto-approved by phuongthuan"}', env_id)
  local temp_file = vim.fn.tempname()

  local file = io.open(temp_file, 'w')
  if not file then
    vim.notify('Failed to create temp file  ', vim.log.levels.ERROR)
    return false
  end

  file:write(json_data)
  file:close()

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
    vim.notify(string.format('Failed to approve: %s  ', result), vim.log.levels.ERROR)
    return false
  end
end

local function check_pending_deployments()
  local pr_number = get_pr_number()
  if not pr_number then
    vim.notify('No pr_number found  ', vim.log.levels.WARN)
    return
  end

  local run_id = get_run_id(pr_number)
  if not run_id then
    vim.notify('No run_id found  ', vim.log.levels.WARN)
    return
  end

  local pending = get_pending_deployments(run_id)
  if not pending or #pending == 0 then
    vim.notify('No approvable pending check found  ', vim.log.levels.WARN)
    return
  end

  print('Pending deployment available 󰸞 ')
end

local function check_and_approve()
  local pr_number = get_pr_number()
  if not pr_number then
    vim.notify('No pr_number found  ', vim.log.levels.WARN)
    return
  end

  local run_id = get_run_id(pr_number)
  if not run_id then
    vim.notify('No run_id found  ', vim.log.levels.WARN)
    return
  end

  local pending = get_pending_deployments(run_id)
  if not pending or #pending == 0 then
    vim.notify('No approvable pending check found  ', vim.log.levels.WARN)
    return
  end

  for _, deployment in ipairs(pending) do
    if deployment.environment.name == 'Development' and deployment.current_user_can_approve then
      approve_deployment(run_id, deployment.environment.id)
      return
    end
  end
end

function M.stop()
  if M.timer then
    M.timer:stop()
    M.timer:close()
    M.timer = nil
  end

  M.enabled = false
  M.current_pr = nil
end

function M.setup()
  local augroup = vim.api.nvim_create_augroup('GHCLIAutoCommands', { clear = true })

  vim.api.nvim_create_user_command('GHCheckAndApproveDeployment', function()
    print('Checking and approving pending deployment 󰔟')
    check_and_approve()
  end, { desc = 'Check and approve pending deployment' })

  vim.api.nvim_create_user_command('GHCheckDeployment', function()
    print('Checking pending deployments 󰔟')
    check_pending_deployments()
  end, { desc = 'Check for pending deployments' })

  vim.api.nvim_create_user_command('GHCreatePR', function()
    if is_pr_exists() then
      functions.open_github_pr()
      return
    end

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
  end, { desc = 'Create PR with custom template' })

  vim.api.nvim_create_user_command('GHCheckoutFromBranch', function()
    functions.checkout_from_branch()
  end, { desc = 'Checkout File From A Branch' })

  vim.api.nvim_create_autocmd('User', {
    group = augroup,
    pattern = 'NeogitPushComplete',
    callback = function()
      if not functions.is_mobile_repo() then
        return
      end

      local choice = vim.fn.confirm('Auto-approve deployment in 4 minutes?', '&Yes\n&No', 1)

      if choice == 1 then
        print('Auto checking and approving will start in 4 minutes 󰔟')
        vim.defer_fn(function()
          print('Auto checking and approving deployment 󰔟')
          local pr_number = get_pr_number()
          if pr_number then
            check_and_approve()
          end
        end, 240000)
      end
    end,
    desc = 'Auto approving deployment after pushed',
  })

  vim.api.nvim_create_autocmd('User', {
    group = augroup,
    pattern = 'NeogitPushComplete',
    callback = function()
      if not functions.is_mobile_repo() then
        return
      end

      if is_pr_exists() then
        functions.open_github_pr()
        return
      end

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
    end,
    desc = 'Auto create PR with custom template after pushed',
  })

  vim.api.nvim_create_autocmd('VimLeavePre', {
    group = augroup,
    callback = M.stop,
    desc = 'Stop GH auto-approval monitoring on exit',
  })
end

return M
