return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }
    require('mini.pairs').setup()
    require('mini.starter').setup()

    -- remove buffer
    local bufremove = require 'mini.bufremove'
    bufremove.setup {}

    vim.keymap.set('n', '<leader>bk', function()
      local bd = bufremove.delete
      if vim.bo.modified then
        local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.bufname()), '&Yes\n&No\n&Cancel')
        if choice == 1 then -- Yes
          vim.cmd.write()
          bd(0)
        elseif choice == 2 then -- No
          bd(0, true)
        end
      else
        bd(0)
      end
    end, { desc = '[B]uffer [K]ill' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
