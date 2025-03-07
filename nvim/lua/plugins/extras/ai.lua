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
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    build = 'make tiktoken',
    config = function()
      require('CopilotChat').setup({
        -- debug = true,
      })

      vim.keymap.set('n', '<leader>cc', '<cmd>CopilotChatToggle<cr>')
    end,
  },
}
