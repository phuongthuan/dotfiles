local nmap = require('core.utils').mapper_factory('n')
local detail = false

return {
  {
    'stevearc/oil.nvim',
    config = function()
      local oil = require('oil')

      oil.setup({
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
          ['<C-h>'] = {
            'actions.select',
            opts = { horizontal = true },
            desc = 'Open the entry in a horizontal split',
          },
          ['<C-r>'] = 'actions.refresh',
          ['gd'] = {
            desc = 'Toggle file detail view',
            callback = function()
              detail = not detail
              if detail then
                oil.set_columns({
                  'icon',
                  'permissions',
                  'size',
                  'mtime',
                })
              else
                oil.set_columns({ 'icon' })
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
    end,
    keys = {
      {
        '<C-f>',
        '<cmd>Oil<cr>',
        desc = 'Open current opened file',
        silent = true,
      },
    },
  },
}
