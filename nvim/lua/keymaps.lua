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

-- keep cursor center when search
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ`z')

-- undo break points
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

-- quicker window movement
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
map('n', '<BS>', '<C-^>') -- switch between last two files
map('n', '<leader>bk', ':bd<CR>')

-----------------------------------------------------------
-- Plugins shortcuts:
-----------------------------------------------------------
-- nvim-tree
map('n', '<C-b>', ':NvimTreeToggle<CR>') -- open/close
map('n', '<C-f>', ':NvimTreeFindFile<CR>') -- search file

-- vista
map('', '<C-m>', ':Vista<CR>')  -- open/close vista window-

-- vsnip
map('n', '<leader>V', ':VsnipOpenVsplit<CR>') -- open vsnip

-- vim-sneak
map('n', 's', '<Plug>Sneak_s', {noremap = false})
map('n', 'S', '<Plug>Sneak_S', {noremap = false})
