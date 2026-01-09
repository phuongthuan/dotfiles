local detail = false

return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-mini/mini.icons', opts = {} },
    lazy = false,
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
          },
          ['<C-s>'] = {
            'actions.select',
            opts = { horizontal = true },
          },
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
          ['<C-r>'] = 'actions.refresh',
          ['<C-y>'] = 'actions.copy_entry_path',
          ['>'] = 'actions.toggle_hidden',

          -- Disabled keymaps
          ['<C-c>'] = false,
          ['<C-p>'] = false,
          ['<C-t>'] = false,
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
  },
  {
    'nvim-mini/mini.files',
    enabled = false,
    config = function()
      local files = require('mini.files')

      files.setup({
        mappings = {
          go_in = '<CR>',
          go_in_plus = 'L',
          go_out = '<C-f>',
          go_out_plus = 'H',
        },
      })
    end,
    keys = {
      {
        '<leader>ee',
        function()
          local files = require('mini.files')

          if not files.close() then
            files.open(vim.fn.getcwd())
          end
        end,
        desc = 'MiniFiles - Toggle Files Explorer',
        silent = true,
      },
      {
        '<C-f>',
        desc = 'MiniFiles - Toggle Current Opened File',
        function()
          local files = require('mini.files')

          if not files.close() then
            files.open(vim.api.nvim_buf_get_name(0))
          end
        end,
        silent = true,
      },
      {
        '<C-v>',
        function()
          local files = require('mini.files')
          local entry = files.get_fs_entry()

          if not entry or entry.fs_type ~= 'file' then
            vim.notify('Not a file', vim.log.levels.WARN)
            return
          end

          files.close()
          vim.cmd('vsplit ' .. vim.fn.fnameescape(entry.path))
        end,
        desc = 'MiniFiles - Open File In Vertical Split',
        silent = true,
      },
      {
        '<C-s>',
        function()
          local files = require('mini.files')
          local entry = files.get_fs_entry()

          if not entry or entry.fs_type ~= 'file' then
            vim.notify('Not a file', vim.log.levels.WARN)
            return
          end

          files.close()
          vim.cmd('split ' .. vim.fn.fnameescape(entry.path))
        end,
        desc = 'MiniFiles - Open File In Horizontal Split',
        silent = true,
      },
    },
  },
}
