local mapper = require('core.utils').mapper_factory
local nmap = mapper('n')
local vmap = mapper('v')

return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'main',
  enabled = false,
  -- version = "v3.3.0", -- Use a specific version to prevent breaking changes
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim' },
  },
  build = 'make tiktoken',
  opts = {
    model = 'claude-sonnet-4',
    prompts = {
      Explain = 'Please explain how the following code works.',
      Review = 'Please review the following code and provide suggestions for improvement.',
      Tests = 'Please explain how the selected code works, then generate unit tests for it.',
      Refactor = 'Please refactor the following code to improve its clarity and readability.',
      FixCode = 'Please fix the following code to make it work as intended.',
      FixError = 'Please explain the error in the following text and provide a solution.',
      BetterNamings = 'Please provide better names for the following variables and functions.',
      Documentation = 'Please provide documentation for the following code.',
      Summarize = 'Please summarize the following text.',
      Wording = 'Please improve the grammar and wording of the following text.',
      Concise = 'Please rewrite the following text to make it more concise.',
    },
    mappings = {
      complete = {
        detail = 'Use @<Tab> or /<Tab> for options.',
        insert = '<Tab>',
      },
      close = {
        normal = 'q',
        insert = '<C-c>',
      },
      reset = {
        normal = '<C-x>',
        insert = '<C-x>',
      },
      accept_diff = {
        normal = '<C-y>',
        insert = '<C-y>',
      },
      show_help = {
        normal = 'g?',
      },
    },
  },
  config = function(_, opts)
    local chat = require('CopilotChat')

    local hostname = (io.popen('hostname'):read('*a') or ''):gsub('%s+', '')
    local user = os.getenv('USER') or hostname or 'User'

    opts.question_header = '🤖 ' .. user .. ' '
    opts.answer_header = '⚡AI '
    opts.error_header = '❌ Error '

    chat.setup(opts)

    nmap('<leader>cok', '<cmd>CopilotChatStop<cr>', { desc = 'Stop CopilotChat' })
    nmap('<leader>cos', '<cmd>CopilotChatSave<cr>', { desc = 'Save CopilotChat Session' })
    nmap('<leader>col', '<cmd>CopilotChatLoad<cr>', { desc = 'Load CopilotChat Session' })
    vmap('<leader>coe', '<cmd>CopilotChatExplain<cr>', { desc = 'Explain Code (CopilotChat)' })
    nmap('<leader>cof', '<cmd>CopilotChatFix<cr>', { desc = 'Fix Code Issues (CopilotChat)' })
    vmap('<leader>cor', '<cmd>CopilotChatReview<cr>', { desc = 'Review Code (CopilotChat)' })
    vmap('<leader>coo', '<cmd>CopilotChatOptimize<cr>', { desc = 'Optimize Code (CopilotChat)' })

    mapper({ 'n', 'v', 'x' })('<C-p>', function()
      chat.select_prompt({ context = { 'buffer' } })
    end, { desc = 'Prompt Actions (CopilotChat)' })

    mapper({ 'n', 'v', 'x' })('<leader>ac', function()
      local input = vim.fn.input('Ask Copilot 🤖')
      if input ~= '' then
        vim.cmd('CopilotChat ' .. input)
      end
    end, { desc = 'Ask Copilot' })
  end,
  keys = {
    {
      '<leader>cc',
      '<cmd>CopilotChatToggle<cr>',
      desc = 'Toggle CopilotChat',
      silent = true,
    },
  },
  event = 'VeryLazy',
}
