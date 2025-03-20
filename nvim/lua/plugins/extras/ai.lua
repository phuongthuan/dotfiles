local prompts = {
  Explain = 'Please explain how the following code works.',
  Review = 'Please review the following code and provide suggestions for improvement.',
  Tests = 'Please explain how the selected code works, then generate unit tests for it.',
  Refactor = 'Please refactor the following code to improve its clarity and readability.',
  FixCode = 'Please fix the following code to make it work as intended.',
  FixError = 'Please explain the error in the following text and provide a solution.',
  BetterNamings = 'Please provide better names for the following variables and functions.',
  Documentation = 'Please provide documentation for the following code.',
  Summarize = 'Please summarize the following text.',
  Spelling = 'Please correct any grammar and spelling errors in the following text.',
  Wording = 'Please improve the grammar and wording of the following text.',
  Concise = 'Please rewrite the following text to make it more concise.',
}

return {
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = {
          enabled = false,
          auto_trigger = true,
          debounce = 50,
          keymap = {
            accept = '¬',
            accept_word = false,
            accept_line = false,
            next = '∆',
            prev = '˚',
            dismiss = '<C-]>',
          },
        },
        panel = {
          enabled = false,
        },
        filetypes = {
          yaml = true,
          markdown = true,
          sh = function()
            if
              string.match(
                vim.fs.basename(vim.api.nvim_buf_get_name(0)),
                '^%.env.*'
              )
            then
              -- disable for .env files
              return false
            end
            return true
          end,
        },
      })
      require('copilot_cmp').setup()
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    -- version = "v3.3.0", -- Use a specific version to prevent breaking changes
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    build = 'make tiktoken',
    opts = {
      prompts = prompts,
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
        show_help = {
          normal = 'g?',
        },
      },
    },
    keys = {
      {
        '<leader>cc',
        ':CopilotChatToggle<CR>',
        desc = 'Toggle Chat',
        silent = true,
      },
      {
        '<leader>ce',
        ':CopilotChatExplain<CR>',
        mode = 'v',
        desc = 'Explain Code',
        silent = true,
      },
      {
        '<leader>cf',
        ':CopilotChatFix<CR>',
        mode = 'v',
        desc = 'Fix Code Issues',
        silent = true,
      },
      {
        '<leader>cm',
        ':CopilotChatCommit<CR>',
        desc = 'Generate Commit Message',
        silent = true,
      },
      {
        '<leader>cs',
        ':CopilotChatCommit<CR>',
        mode = 'v',
        desc = 'Generate Commit for Selection',
        silent = true,
      },
      {
        '<leader>cd',
        ':CopilotChatDocs<CR>',
        mode = 'v',
        desc = 'Generate Docs',
        silent = true,
      },
      {
        '<leader>cd',
        ':CopilotChatTests<CR>',
        mode = 'v',
        desc = 'Generate Tests',
        silent = true,
      },
      {
        '<leader>cr',
        ':CopilotChatReview<CR>',
        mode = 'v',
        desc = 'Review Code',
        silent = true,
      },
      {
        '<leader>co',
        ':CopilotChatOptimize<CR>',
        mode = 'v',
        desc = 'Optimize Code',
        silent = true,
      },
      {
        '<leader>ai',
        function()
          local input = vim.fn.input('Ask AI 👽: ')
          if input ~= '' then
            vim.cmd('CopilotChat ' .. input)
          end
        end,
        mode = { 'n', 'v', 'x' },
        desc = 'Ask Input',
        silent = true,
      },
      {
        '<leader>ap',
        function()
          require('CopilotChat').select_prompt({
            context = {
              'buffers',
            },
          })
        end,
        desc = 'CopilotChat - Prompt actions',
        silent = true,
      },
    },
    config = function(_, opts)
      local chat = require('CopilotChat')

      local hostname = (io.popen('hostname'):read('*a') or ''):gsub('%s+', '')
      local user = os.getenv('USER') or hostname or 'User'

      opts.question_header = '🐸 ' .. user .. ' '
      opts.answer_header = '⚡AI '
      opts.error_header = '❌ Error '

      opts.prompts.Commit = {
        prompt = '> #git:staged\n\nWrite a git commit message that summarizes all changes of each file. Write clear, informative commit messages. Including file path so for user to easy access in github.',
      }

      chat.setup(opts)

      vim.keymap.set(
        'n',
        '<leader>cs',
        ':CopilotChatStop<CR>',
        { silent = true }
      )
      vim.keymap.set('n', '<leader>cw', ':CopilotChatSave')
      vim.keymap.set('n', '<leader>cl', ':CopilotChatLoad')
    end,
    event = 'VeryLazy',
  },
}
