local g = vim.g
local map = require('utils').map

-- Plugin: justinmk/vim-sneak
--- https://github.com/justinmk/vim-sneak

g["sneak#label"] = true
g["sneak#use_ic_scs"] = true

map('n', 's', '<Plug>Sneak_s', {noremap = false})
map('n', 'S', '<Plug>Sneak_S', {noremap = false})
