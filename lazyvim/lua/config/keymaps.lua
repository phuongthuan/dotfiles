local variable = require("phuongthuan.variable")

local map = vim.keymap.set

-- Open today note
local new_note_file = variable.icloud_drive_obsidian_path .. "/diary/" .. os.date("%Y-%m-%d") .. ".md"
map("n", "<leader>td", ":e " .. new_note_file .. "<cr>", { desc = "Open today note", noremap = false })

-- Open EH configuration
map("n", "<leader>eh", ":e " .. variable.eh_config_path .. "<cr>", { desc = "Open EH configuration" })

-- Map Esc to jk
map("i", "jk", "<Esc>", { noremap = true })

-- Z{symbol} to select inside
map("n", "Z", "vi")

-- Buffers next and prev
map("n", "<tab>", ":bp<CR>")
map("n", "<S-tab>", ":bn<CR>")

-- Switch between last two files
map("n", "<BS>", "<C-^>")

-- Close window without save
map("n", "<leader>q", ":q!<cr>")

-- Select all file
map("n", "<leader>a", ":keepjumps normal! ggVG<cr>")

-- Prevent to used arrow keys ;)
map("", "<up>", "<nop>", { noremap = true })
map("", "<down>", "<nop>", { noremap = true })
map("", "<left>", "<nop>", { noremap = true })
map("", "<right>", "<nop>", { noremap = true })

-- Keep cursor center when search
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

-- Make life more easier
map("n", "H", "^")
map("o", "H", "^")
map("x", "H", "^")
map("o", "L", "$")
map("n", "L", "$")
map("x", "L", "$")

-- Undo break points
map("i", ".", ".<c-g>u")
map("i", "[", "[<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")

-- Moving line
map("n", "<leader>j", "<cmd>m .+1<cr>==")
map("n", "<leader>k", "<cmd>m .-2<cr>==")
map("i", "<leader>j", "<esc><cmd>m .+1<cr>==gi")
map("i", "<leader>k", "<esc><cmd>m .-2<cr>==gi")
map("v", "<leader>j", ":m '>+1<cr>gv=gv")
map("v", "<leader>k", ":m '<-2<cr>gv=gv")

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Delete without changing the registers
map({ "n", "x" }, "x", '"_x')
map("x", "<leader>p", '"_dP')

-- Replace multiple words
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Get current file path
map(
  "n",
  "<leader>cp",
  [[:let @+=expand("%:p")<CR>:echo "File path copied to clipboard!"<CR>]],
  { noremap = true, silent = true }
)

-- Vim-fugitive
map("n", "<leader>g", ":G<cr>")
map("n", "<leader>gp", ":G push origin HEAD<cr>")
map("n", "<leader>gP", ":G push origin HEAD -f<cr>")
