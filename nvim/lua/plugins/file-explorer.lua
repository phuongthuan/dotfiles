local nmap = require('core.utils').mapper_factory('n')
local detail = false

return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup({
      default_file_explorer = true,
      view_options = { show_hidden = true },
      win_options = { wrap = true },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ['<C-v>'] = {
          'actions.select',
          opts = { vertical = true },
          desc = 'Open the entry in a vertical split',
        },
        ['<C-r>'] = 'actions.refresh',
        ['gd'] = {
          desc = 'Toggle file detail view',
          callback = function()
            detail = not detail
            if detail then
              require('oil').set_columns({
                'icon',
                'permissions',
                'size',
                'mtime',
              })
            else
              require('oil').set_columns({ 'icon' })
            end
          end,
        },
        -- Disabled keymaps
        ['<C-t>'] = false,
        ['<C-p>'] = false,
        ['<C-s>'] = false,
        ['<C-b>'] = false,
        ['<C-l>'] = false,
        ['gs'] = false,
      },
    })

    -- Keymaps
    nmap('<C-f>', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
  end,
}

-- return {
--   'nvim-neo-tree/neo-tree.nvim',
--   version = '*',
--   dependencies = {
--     'nvim-lua/plenary.nvim',
--     'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
--     'MunifTanjim/nui.nvim',
--   },
--   cmd = 'Neotree',
--   keys = {
--     {
--       '<C-f>',
--       '<cmd>Neotree reveal<cr>',
--       { desc = 'NeoTree reveal', silent = true },
--     },
--     {
--       '<C-b>',
--       '<cmd>Neotree toggle<cr>',
--       { desc = 'NeoTree toggle', silent = true },
--     },
--   },
--   opts = {
--     filesystem = {
--       window = {
--         mappings = {
--           ['<C-b>'] = 'close_window',
--         },
--       },
--     },
--   },
-- }
