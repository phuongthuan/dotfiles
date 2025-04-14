local nmap = require('core.utils').mapper_factory('n')

return {
  'ThePrimeagen/harpoon',
  config = function()
    require('harpoon').setup({
      menu = {
        width = 100,
      },
    })

    -- Keymaps
    nmap('<C-a>', '<cmd>lua require("harpoon.mark").add_file()<cr>:echo " Bookmarked 🌟"<cr>')
    nmap('<C-e>', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>')
    nmap('<leader>1', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>')
    nmap('<leader>2', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>')
    nmap('<leader>3', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>')
    nmap('<leader>4', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>')
    nmap('<leader>5', '<cmd>lua require("harpoon.ui").nav_file(5)<cr>')
    nmap('<leader><leader>t', '<cmd>lua require("harpoon.term").gotoTerminal(1)<cr>')
  end,
}
