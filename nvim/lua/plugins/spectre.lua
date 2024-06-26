return {
  'nvim-pack/nvim-spectre',
  config = function()
    require('spectre').setup()

    -- Keymaps
    vim.keymap.set('n', '<leader>sr', '<cmd>lua require("spectre").toggle()<cr>', { desc = 'Toggle Spectre' })
    -- vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<cr>', { desc = 'Search current word' })
    -- vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<cr>', { desc = 'Search current word' })
    vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
      desc = 'Search on current file',
    })
  end,
}
