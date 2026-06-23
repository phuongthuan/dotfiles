local f = require('functions')

local command = vim.api.nvim_create_user_command --[[@type function]]

command('GHBuildExpo', f.trigger_expo_build, { desc = 'Build eh-mobile-pro with Expo' })

command(
  'GHBuildAndRunE2EIOS',
  f.trigger_build_and_run_e2e_test('ios'),
  { desc = 'Build and run eh-mobile-pro E2E iOS' }
)
command(
  'GHBuildAndRunE2EAndroid',
  f.trigger_build_and_run_e2e_test('android'),
  { desc = 'Build and run eh-mobile-pro E2E Android' }
)
command('GHRunE2EIOS', f.trigger_run_e2e_test('ios'), { desc = 'Run eh-mobile-pro E2E iOS' })
command('GHRunE2EAndroid', f.trigger_run_e2e_test('android'), { desc = 'Run eh-mobile-pro E2E Android' })

command('GHOpen', f.open_my_github, { desc = 'Open GitHub' })
command('GHOpenPR', f.open_github_pr, { desc = 'Open GitHub PR' })

command('GHOpenPRList', function(opts)
  -- Only parse args if provided
  if opts.args and opts.args ~= '' then
    local args = vim.split(opts.args, '%s+')
    local project = args[1]
    local author = args[2]
    f.open_github_author_pr_list(project, author)
  else
    -- No args: trigger interactive pickers
    f.open_github_author_pr_list()
  end
end, { nargs = '*', desc = 'Open GitHub PR List (interactive or with args)' })

command('GHOpenWorkflows', f.open_github_workflow, { desc = 'Open GitHub Workflows' })
command('GHPRNumber', f.get_pr_number, { desc = 'Get GitHub PR Number' })
