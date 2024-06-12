return {
  'ThePrimeagen/harpoon',
  config = function()
    require('harpoon').setup {
      menu = {
        width = 100,
      },
    }

    -- Keymaps
    vim.keymap.set('n', '<C-a>', '<cmd>lua require("harpoon.mark").add_file()<cr>:echo "Bookmarked 🌟"<cr>')
    vim.keymap.set('n', '<C-e>', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>')
    vim.keymap.set('n', '<leader>1', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>')
    vim.keymap.set('n', '<leader>2', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>')
    vim.keymap.set('n', '<leader>3', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>')
    vim.keymap.set('n', '<leader>4', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>')
    vim.keymap.set('n', '<leader>5', '<cmd>lua require("harpoon.ui").nav_file(5)<cr>')
  end,
}
