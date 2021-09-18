-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim
--- and plugins.
-----------------------------------------------------------

local map = require('utils').map
local cmd = vim.cmd

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- buffers stuff
map('n', '<tab>', ':bp<CR>')
map('n', '<S-tab>', ':bn<CR>')
map('n', '<BS>', '<C-^>') -- switch between last two files
map('n', '<leader>bk', ':bd<CR>')

-- make life more easier
map('n', 'H', '^')
map('o', 'H', '^')
map('x', 'H', '^')
map('o', 'L', '$')
map('n', 'L', '$')
map('x', 'L', '$')

-- Y to copy to end of line
map('n', 'Y', 'y$')

-- Z{symbol} to copy inside
map('n', 'Z', 'yi')

-- select all file
map('n', '<leader>a', 'ggVG')

-- create folder
map('n', '<leader><leader>cf', ':!mkdir -p<Space>')

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
map('v', '<leader>j', ":m'>+<cr>`<my`>mzgv`yo`z")
map('v', '<leader>k', ":m'<-2<cr>`>my`<mzgv`yo`z")
map('n', '<leader>k', "mz:m-2<cr>`z")
map('n', '<leader>j', "mz:m+<cr>`z")

-- keep visual mode indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- clear search highlighting
map('n', '<Esc>', ':nohl<CR>')

-- map Esc to jk
map('i', 'jk', '<Esc>', {noremap = true})

-- prevent to used arrow keys ;)
map('', '<up>', '<nop>', {noremap = true})
map('', '<down>', '<nop>', {noremap = true})
map('', '<left>', '<nop>', {noremap = true})
map('', '<right>', '<nop>', {noremap = true})

-- source Vim configuration file and install plugins
map('n', '<leader><leader>1', ':source ~/.config/nvim/init.lua<CR>:echo "Reloaded ~/.config/nvim/init.lua"<CR>')

-- fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>')

-- source file and install plugins
map('n', '<leader>P', ':so %<CR>:PaqInstall<CR>')

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
-- Custom function and shortcuts
-----------------------------------------------------------
-- rename current file
cmd [[
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <Leader>rnf :call RenameFile()<cr>
]]

-- Open file in same directory
cmd [[
  nnoremap ,e :e <C-R>=expand('%:p:h') . '/'<CR>
]]
