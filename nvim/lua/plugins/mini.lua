local nmap = require('core.utils').mapper_factory('n')

return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.ai').setup({ n_lines = 500 })
      require('mini.pairs').setup()
      require('mini.starter').setup()
      require('mini.indentscope').setup()
    end,
  },
  {
    'echasnovski/mini.hipatterns',
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
  {
    'echasnovski/mini.bufremove',
    config = function()
      local bufremove = require('mini.bufremove')
      bufremove.setup()

      -- Kill the current buffer
      nmap('<leader>z', function()
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
      end, { desc = 'Kill current buffer' })
    end,
  },
}
