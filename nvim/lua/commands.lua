local functions = require('core.functions')

local command = vim.api.nvim_create_user_command

command('GHBuildExpo', functions.trigger_expo_build, { desc = 'Build eh-mobile-pro with Expo' })
command('GHOpen', functions.open_my_github, { desc = 'Open GitHub' })
command('GHOpenPR', functions.open_github_pr, { desc = 'Open GitHub PR' })
command('GHOpenWorkflows', functions.open_github_workflows, { desc = 'Open GitHub Workflows' })
command('GHPRNumber', functions.get_pr_number, { desc = 'Get GitHub PR Number' })
