-----------------------------------------------------------
-- Harpoon
-----------------------------------------------------------

local map = require('utils').map

-- Plugin: harpoon
--- https://github.com/ThePrimeagen/harpoon

require('harpoon').setup({
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
    },
})

-- Keymaps
map('n', '<C-a>', ':lua require("harpoon.mark").add_file()<CR>:echo "Added to harpoon!!"<CR>')
map('n', '<C-e>', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')

map('n', '<leader>1', ':lua require("harpoon.ui").nav_file(1)<CR>')
map('n', '<leader>2', ':lua require("harpoon.ui").nav_file(2)<CR>')
map('n', '<leader>3', ':lua require("harpoon.ui").nav_file(3)<CR>')
map('n', '<leader>4', ':lua require("harpoon.ui").nav_file(4)<CR>')
map('n', '<leader>5', ':lua require("harpoon.ui").nav_file(5)<CR>')
