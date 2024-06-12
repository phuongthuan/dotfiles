local env = require("env")

local cmd = vim.cmd
local map = vim.keymap.set

-- Open today note
local new_note_file = env.icloud_drive_obsidian_path .. "/diary/" .. os.date("%Y-%m-%d") .. ".md"
map("n", "<leader>td", ":e " .. new_note_file .. "<cr>", { noremap = false })

-- Source Vim configuration file and install plugins
map("n", "<leader><leader>1", ":source " .. env.nvim_config_path .. '<cr>:echo " Reloaded neovim config !!"<cr>')

-- Open file in same directory
cmd([[ nnoremap ,e :e <C-R>=expand('%:p:h') . '/'<cr> ]])

-- Open EH configuration
map("n", "<leader>eh", ":e " .. env.eh_config_path .. "<cr>")

-- Windows remapping
-- Vertically split screen
map("n", "<leader>wv", ":vs<cr>")
map("n", "<leader>ws", ":split<cr>")

-- Close window
map("n", "<leader>wc", ":wq<cr>")

-- Close window without save
map("n", "<leader>q", ":q!<cr>")

-- Quicker window movement
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Buffers stuff
map("n", "<tab>", ":bp<cr>")
map("n", "<S-tab>", ":bn<cr>")
map("n", "<BS>", "<C-^>") -- switch between last two files
map("n", "<leader>bk", ":bd<cr>")

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
map("n", "<leader>a", ":keepjumps normal! ggVG<cr>")

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
map("n", "<Esc>", ":nohl<cr>")

-- Map Esc to jk
map("i", "jk", "<Esc>", { noremap = true })

-- Prevent to used arrow keys ;)
map("", "<up>", "<nop>", { noremap = true })
map("", "<down>", "<nop>", { noremap = true })
map("", "<left>", "<nop>", { noremap = true })
map("", "<right>", "<nop>", { noremap = true })

-- Fast saving with <leader> and s
map("n", "<leader>s", ":w<cr>")

-- Saving all working buffers
map("n", "<leader>S", ":wa<cr>")

-- Source file and install plugins
map("n", "<leader>L", ":Lazy<cr>")

-- Delete without changing the registers
map({ "n", "x" }, "x", '"_x')
map("x", "<leader>p", '"_dP')

-- Replace multiple words
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

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
