local cmd = vim.cmd
local map = vim.keymap.set

-- Source Vim configuration file and install plugins
map("n", "<leader><leader>1", ':source ~/.config/nvim/init.lua<CR>:echo "Reloaded ~/.config/nvim/init.lua"<CR>')

-- Open file in same directory
cmd([[ nnoremap ,e :e <C-R>=expand('%:p:h') . '/'<CR> ]])

-- Open EH configuration
map("n", "<leader>eh", ":e ~/.dotfiles/zsh/eh.zsh<CR>")

-- Windows remapping
-- Vertically split screen
map("n", "<leader>wv", ":vs<CR>")
map("n", "<leader>ws", ":split<CR>")

-- Close window
map("n", "<leader>wc", ":wq<CR>")

-- Close window without save
map("n", "<leader>q", ":q!<CR>")

-- Quicker window movement
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Buffers stuff
map("n", "<tab>", ":bp<CR>")
map("n", "<S-tab>", ":bn<CR>")
map("n", "<BS>", "<C-^>") -- switch between last two files
map("n", "<leader>bk", ":bd<CR>")

-- Make life more easier
map("n", "H", "^")
map("o", "H", "^")
map("x", "H", "^")
map("o", "L", "$")
map("n", "L", "$")
map("x", "L", "$")

-- Z{symbol} to copy inside
map("n", "Z", "yi")

-- Select all file
map("n", "<leader>a", ":keepjumps normal! ggVG<CR>")

-- Create folder
map("n", "<leader><leader>cf", ":!mkdir -p<Space>")

-- Keep cursor center when search
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

-- Undo break points
map("i", ".", ".<c-g>u")
map("i", "[", "[<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")

-- Moving line
map("v", "<leader>j", ":m'>+<cr>`<my`>mzgv`yo`z")
map("v", "<leader>k", ":m'<-2<cr>`>my`<mzgv`yo`z")
map("n", "<leader>k", "mz:m-2<cr>`z")
map("n", "<leader>j", "mz:m+<cr>`z")

-- Keep visual mode indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Clear search highlighting
map("n", "<Esc>", ":nohl<CR>")

-- Map Esc to jk
map("i", "jk", "<Esc>", { noremap = true })

-- Prevent to used arrow keys ;)
map("", "<up>", "<nop>", { noremap = true })
map("", "<down>", "<nop>", { noremap = true })
map("", "<left>", "<nop>", { noremap = true })
map("", "<right>", "<nop>", { noremap = true })

-- Fast saving with <leader> and s
map("n", "<leader>s", ":w<CR>")

-- Saving all working buffers
map("n", "<leader>S", ":wa<CR>")

-- Source file and install plugins
map("n", "<leader>L", ":Lazy<CR>")

-- Delete without changing the registers
map({ "n", "x" }, "x", '"_x')

map("x", "<leader>p", '"_dP')

-- Rename current file
cmd([[
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
]])
