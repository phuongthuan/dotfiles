-----------------------------------------------------------
-- Vim Fugitive
-----------------------------------------------------------

local map = require('utils').map

-- Plugin: vim-fugitive
--- https://github.com/tpope/vim-fugitive

-- Status/Log
map('n', '<leader>gs', ':G<CR>')
map('n', '<leader>gl', ':G log<CR>')

-- Branch
map('n', '<leader>go', ':G checkout<Space>')
map('n', '<leader>gom', ':G checkout master<CR>')
map('n', '<leader>gb', ':G branch<Space>')
map('n', '<leader>gd', ':G diff<CR>')

-- Push/Pull
map('n', '<leader>gp', ':G push origin HEAD<CR>')
map('n', '<leader>gP', ':G push origin master<CR>')

map('n', '<leader>gpl', ':G pull origin HEAD<CR>')

-- Merge/Rebase
map('n', '<leader>gm', ':G merge<Space>')
map('n', '<leader>gr', ':G rebase<Space>')
