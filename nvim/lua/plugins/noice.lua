return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {
        cmdline = {
          format = {
            cmdline = { pattern = '^:', icon = '🖥️', lang = 'vim' },
            search_down = { kind = 'search', pattern = '^/', icon = '🔍 ', lang = 'regex' },
            search_up = { kind = 'search', pattern = '^%?', icon = '🔍 ', lang = 'regex' },
            input = { view = 'cmdline_input', icon = '📝' }, -- Used by input()k
          },
        },
        -- views = {
        --   cmdline_popup = {
        --     border = {
        --       style = 'none',
        --       padding = { 2, 3 },
        --     },
        --     filter_options = {},
        --     win_options = {
        --       winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
        --     },
        --   },
        -- },
      }

      vim.keymap.set('n', '<leader>er', ':Noice telescope<cr>', { desc = 'Open message history', silent = true })
      vim.keymap.set('n', '<leader>un', ':Noice dismiss<cr>', { desc = 'Open message history', silent = true })
    end,
  },
}
