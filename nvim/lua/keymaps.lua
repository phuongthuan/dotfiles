-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim
--- and plugins.
-----------------------------------------------------------

local utils = require('utils')
local map = utils.map

-----------------------------------------------------------
-- Neovim shortcuts:
-----------------------------------------------------------

map('n', 'H', '^')
map('o', 'H', '^')
map('x', 'H', '^')
map('o', 'L', '$')
map('n', 'L', '$')
map('x', 'L', '$')

map('n', 'Y', 'y$')

-- undo break points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', '[', '[<c-g>u')
map('i', '!', '!<c-g>u')
map('i', '?', '?<c-g>u')

-- moving line
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")
map('i', '<C-j>', "<Esc>:m .+1<CR>==")
map('i', '<C-k>', "<Esc>:m .-2<CR>==")
map('n', '<leader>k', ":m .-2<CR>==")
map('n', '<leader>j', ":m .+1<CR>==")

-- remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- basic autopair
map('i', '"', '""<left>')
map('i', '`', '``<left>')
map('i', '(', '()<left>')
map('i', '[', '[]<left>')
map('i', '{', '{}<left>')
map('i', '{<CR>', '{<CR}<ESC>0')
map('i', '{;<CR>', '{<CR};<ESC>0')

-- clear search highlighting
map('n', '<Esc>', ':nohl<CR>')

-- open terminal
map('n', '<leader>T', ':term<CR>')

-- map Esc to jk
map('i', 'jk', '<Esc>', {noremap = true})

-- prevent to used arrow keys ;)
map('', '<up>', '<nop>', {noremap = true})
map('', '<down>', '<nop>', {noremap = true})
map('', '<left>', '<nop>', {noremap = true})
map('', '<right>', '<nop>', {noremap = true})

-- source Vim configuration file and install plugins
map('n', '<leader><leader>1', ':source %<CR>')

-- fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>')

-- move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- vertically split screen
map('n', '<leader>wv', ':vs<CR>')
map('n', '<leader>ws', ':split<CR>')

-- close windown
map('n', '<leader>wc', ':wq<CR>')

-- close window without save
map('n', '<leader>q', ':q!<CR>')

-----------------------------------------------------------
-- Buffers shortcuts:
-----------------------------------------------------------
map('n', '<tab>', ':bp<CR>')
map('n', '<S-tab>', ':bn<CR>')
map('n', '<leader>bk', ':bd<CR>')

-----------------------------------------------------------
-- Plugins shortcuts:
-----------------------------------------------------------
-- nvim-tree
map('n', '<C-b>', ':NvimTreeToggle<CR>') -- open/close
-- map('n', '<C-r>', ':NvimTreeRefresh<CR>')  -- refresh
map('n', '<C-f>', ':NvimTreeFindFile<CR>') -- search file

-- vista
map('', '<C-m>', ':Vista<CR>')  -- open/close vista window-

-- FZF
map('n', '<C-p>', ':Files<CR>')
map('n', '<leader>bb', ':Buffers<CR>') -- list all buffers
map('n', '<leader>sb', ':Lines<CR>') -- search in all buffers
map('n', '<leader>h', ':History<CR>') -- show recent open file
map('n', '<leader>sf', ':BLines<CR>') -- search in current buffer
map('n', '<leader>sa', ':Rg<CR>') -- search ripgrep
map('n', '<leader>C', ':Commands<CR>')
map('n', '<leader>gg', ':GFiles?<CR>') -- git status

-- vsnip
map('n', '<leader>V', ':VsnipOpenVsplit<CR>') -- open vsnip

-- vim-sneak
map('n', 's', '<Plug>Sneak_s', {noremap = false})
map('n', 'S', '<Plug>Sneak_S', {noremap = false})

-- map('n', 'f', '<Plug>Sneak_f', {noremap = false})
-- map('n', 'F', '<Plug>Sneak_F', {noremap = false})
-- map('n', 't', '<Plug>Sneak_t', {noremap = false})
-- map('n', 'T', '<Plug>Sneak_T', {noremap = false})

-- vimwiki
-- map('n', '<leader>td', '<Plug>vimwikimakediarynote', {noremap = false})
-- map('n', '<leader>yt', '<Plug>vimwikimakeyesterdaydiarynote', {noremap = false})
-- map('n', '<leader>tm', '<Plug>vimwikimaketomorrowdiarynote', {noremap = false})

