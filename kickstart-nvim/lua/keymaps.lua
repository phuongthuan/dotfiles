local env = require 'env'

local map = vim.keymap.set
local cmd = vim.cmd

-- Open today note
local new_note_file = env.icloud_drive_obsidian_path .. '/diary/' .. os.date '%Y-%m-%d' .. '.md'
map('n', '<leader>td', ':e ' .. new_note_file .. '<cr>', { desc = '[T]o[D]ay note', noremap = false })

-- Source Neovim configuration
map('n', '<leader><leader>1', ':source ' .. env.nvim_kickstart_config_path .. '<cr>:echo "Reloaded neovim config 🚀"<cr>')

-- Open file in same directory
cmd [[ nnoremap ,e :e <C-R>=expand('%:p:h') . '/'<cr> ]]

-- Open EH configuration
map('n', '<leader>eh', ':e ' .. env.eh_config_path .. '<cr>', { desc = 'Open EH configuration' })

-- Fast saving with <leader> and s
map('n', '<leader>s', ':w<cr>:echo "Saved current buffer ✅"<cr>')

-- Saving all working buffers
map('n', '<leader>S', ':wa<cr>:echo "Saved all buffers ✅"<cr>')

-- Map Esc to jk
map('i', 'jk', '<Esc>', { noremap = true })

-- Z{symbol} to select inside
map('n', 'Z', 'vi')

-- Buffers next and prev
map('n', '<tab>', ':bp<CR>')
map('n', '<S-tab>', ':bn<CR>')

-- Switch between last two files
map('n', '<BS>', '<C-^>')

-- Close window without save
map('n', '<leader>q', ':q!<cr>')

-- Select all file
map('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Prevent to used arrow keys ;)
map('', '<up>', '<nop>', { noremap = true })
map('', '<down>', '<nop>', { noremap = true })
map('', '<left>', '<nop>', { noremap = true })
map('', '<right>', '<nop>', { noremap = true })

-- Keep cursor center when search
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ`z')

-- Make life more easier
map('n', 'H', '^')
map('o', 'H', '^')
map('x', 'H', '^')
map('o', 'L', '$')
map('n', 'L', '$')
map('x', 'L', '$')

-- Undo break points
map('i', '.', '.<c-g>u')
map('i', '[', '[<c-g>u')
map('i', '!', '!<c-g>u')
map('i', '?', '?<c-g>u')

-- Keep visual mode indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Moving line
map('n', '<leader>j', '<cmd>m .+1<cr>==')
map('n', '<leader>k', '<cmd>m .-2<cr>==')
map('i', '<leader>j', '<esc><cmd>m .+1<cr>==gi')
map('i', '<leader>k', '<esc><cmd>m .-2<cr>==gi')
map('v', '<leader>j', ":m '>+1<cr>gv=gv")
map('v', '<leader>k', ":m '<-2<cr>gv=gv")

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Delete without changing the registers
map({ 'n', 'x' }, 'x', '"_x')
map('x', '<leader>p', '"_dP')

-- Replace multiple words
map('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Get current file path
map('n', '<leader>cp', [[:let @+=expand("%:p")<CR>:echo " File path copied to clipboard 📝"<cr>]], { noremap = true, silent = true })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
-- map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move ❌"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move ❌"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move ❌"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move ❌"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- =========================================== Plugins keymaps ==============================================

-- Vim-fugitive
map('n', '<leader>g', ':G<cr>')
map('n', '<leader>gp', ':G push origin HEAD<cr>')
map('n', '<leader>gP', ':G push origin HEAD -f<cr>')

-- Mason
map('n', '<leader>ms', '<cmd>Mason<cr>')
