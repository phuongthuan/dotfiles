return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.ai').setup({ n_lines = 500 })
    require('mini.pairs').setup()
    require('mini.icons').setup()
    require('mini.starter').setup()

    require('mini.files').setup({
      mappings = {
        go_in = '<CR>',
        go_in_plus = 'L',
        go_out = '-',
        go_out_plus = 'H',
      },
    })
    -- keymaps
    vim.keymap.set('n', '<leader>ee', '<cmd>lua MiniFiles.open()<CR>', { desc = 'Toggle Mini Files Explorer' })
    vim.keymap.set('n', '<leader>ef', function()
      MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
      MiniFiles.reveal_cwd()
    end, { desc = 'Toggle Current Opened File' })

    -- remove buffer
    local bufremove = require('mini.bufremove')
    bufremove.setup({})

    vim.keymap.set('n', '<leader>dB', function()
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
