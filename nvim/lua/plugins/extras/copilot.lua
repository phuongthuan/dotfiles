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
      })
      require('copilot_cmp').setup()
    end,
  },
  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   branch = 'canary',
  --   dependencies = {
  --     { 'zbirenbaum/copilot.lua' },
  --     { 'nvim-lua/plenary.nvim' },
  --   },
  --   config = function()
  --     require('CopilotChat').setup({
  --       debug = true,
  --     })
  --
  --     vim.keymap.set('n', '<leader>cc', '<cmd>CopilotChat<cr>')
  --   end,
  -- },
}
