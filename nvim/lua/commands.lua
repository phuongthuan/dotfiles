local functions = require('core.functions')

local command = vim.api.nvim_create_user_command

command('GHBuildExpo', functions.trigger_expo_build, { desc = 'Build eh-mobile-pro with Expo' })

command(
  'GHBuildE2EIOS',
  functions.trigger_build_maestro_e2e_test('ios'),
  { desc = 'Build eh-mobile-pro Maestro E2E iOS' }
)
command(
  'GHBuildE2EAndroid',
  functions.trigger_build_maestro_e2e_test('android'),
  { desc = 'Build eh-mobile-pro Maestro E2E Android' }
)
command('GHRunE2EIOS', functions.trigger_run_maestro_e2e_test('ios'), { desc = 'Run eh-mobile-pro Maestro E2E iOS' })
command(
  'GHRunE2EAndroid',
  functions.trigger_run_maestro_e2e_test('android'),
  { desc = 'Run eh-mobile-pro Maestro E2E Android' }
)

command('GHOpen', functions.open_my_github, { desc = 'Open GitHub' })

command('GHOpenPR', functions.open_github_pr, { desc = 'Open GitHub PR' })

command('GHOpenPRList', function(opts)
  -- Only parse args if provided
  if opts.args and opts.args ~= '' then
    local args = vim.split(opts.args, '%s+')
    local project = args[1]
    local author = args[2]
    functions.open_github_author_pr_list(project, author)
  else
    -- No args: trigger interactive pickers
    functions.open_github_author_pr_list()
  end
end, { nargs = '*', desc = 'Open GitHub PR List (interactive or with args)' })

command('GHOpenWorkflows', functions.open_github_workflow, { desc = 'Open GitHub Workflows' })
command('GHPRNumber', functions.get_pr_number, { desc = 'Get GitHub PR Number' })
