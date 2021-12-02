-----------------------------------------------------------
-- Vim Fugitive
-----------------------------------------------------------

local map = require('utils').map

-- Plugin: vim-fugitive
--- https://github.com/tpope/vim-fugitive

map('n', '<leader>gs', ':G<CR>')
map('n', '<leader>gl', ':G log<CR>')

map('n', '<leader>go', ':G checkout<Space>')
map('n', '<leader>gb', ':G branch<Space>')
map('n', '<leader>gd', ':G diff<CR>')
