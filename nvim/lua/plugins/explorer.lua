local detail = false

return {
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
        -- ['<C-h>'] = {
        --   'actions.select',
        --   opts = { horizontal = true },
        --   desc = 'Open the entry in a horizontal split',
        -- },
        ['<C-r>'] = 'actions.refresh',
        ['gd'] = {
          desc = 'Oil - Toggle File Detail View',
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
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['gs'] = false,
      },
    })
  end,
  keys = {
    {
      '<C-f>',
      '<cmd>Oil<cr>',
      desc = 'Oil - Open Current Opened File',
      silent = true,
    },
  },
}
