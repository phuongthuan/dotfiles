local map = require('utils').map

-- Plugin: vim-fugitive
--- https://github.com/tpope/vim-fugitive

-- Status/Log
map('n', '<leader>g', ':G<CR>')
map('n', '<leader>gl', ':G log<CR>')

-- Branch
map('n', '<leader>go', ':G checkout<Space>')
map('n', '<leader>gom', ':G checkout master<CR>')
map('n', '<leader>gd', ':G diff<CR>')

-- Push/Pull
map('n', '<leader>gp', ':G push origin HEAD<CR>')
map('n', '<leader>gpm', ':G push origin master<CR>')

-- Merge/Rebase
map('n', '<leader>gm', ':G merge<Space>')
map('n', '<leader>gr', ':G rebase<Space>')

-- Resolve conflict
map('n', '<leader>rc', ':Gvdiffsplit!<CR>')
