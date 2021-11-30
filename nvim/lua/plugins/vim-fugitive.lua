-----------------------------------------------------------
-- Vim Fugitive
-----------------------------------------------------------

local map = require('utils').map

-- Plugin: vim-fugitive
--- https://github.com/tpope/vim-fugitive

map('n', '<leader>gg', ':G<CR>')
map('n', '<leader>gl', ':G log<CR>')
