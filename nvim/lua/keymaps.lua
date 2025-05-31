local env = require('core.env')
local mapper = require('core.utils').mapper_factory

local nmap = mapper('n')
local vmap = mapper('v')
local imap = mapper('i')
local tmap = mapper('t')
local xmap = mapper('x')
local omap = mapper('o')

-- Open today note
local new_note_file = env.PERSONAL_NOTES .. '/diary/' .. os.date('%Y-%m-%d') .. '.md'
nmap('<leader>td', ':e ' .. new_note_file .. '<cr>', { noremap = false })

-- Source Neovim configuration
nmap(
  '<leader><leader>1',
  ':source ' .. env.NVIM_CONFIG_DIR .. '/init.lua' .. '<cr>:echo " Reloaded Neovim config 🚀"<cr>'
)

-- Open file in same directory
-- cmd([[ nnoremap ,e :e <C-R>=expand('%:p:h') . '/'<cr> ]])

-- Open EH configuration
nmap('<leader>eh', ':e ' .. env.EH_CONFIG_FILE .. '<cr>', { desc = 'Open EH configuration' })
nmap('<leader>sc', ':e ' .. env.SECRET_ENV_FILE .. '<cr>', { desc = 'Open Secret configuration' })

-- No need to keep holding shift
nmap(';', ':', { silent = false })
vmap(';', ':', { silent = false })

-- Fast saving with <leader> and s
nmap('<leader>s', ':w<cr>:echo " Saved current file ✅"<cr>')

-- :wq
nmap('<leader>w', ':wq<cr>:echo " Git commit created ✅"<cr>')

-- Saving all working buffers
nmap('<leader>S', ':wa<cr>:echo " Saved all files ✅"<cr>')

-- Map Esc to jk
imap('jk', '<Esc>', { noremap = true })

-- Z{symbol} to select inside
nmap('Z', 'yi')

-- Buffers next and prev
nmap('<tab>', ':bp<cr>')
nmap('<S-tab>', ':bn<cr>')

-- Switch between last two files
nmap('<BS>', '<C-^>')

-- Close window without save
nmap('<leader>q', ':q!<cr>')

-- Select all file
nmap('<leader>a', ':keepjumps normal! ggVG<cr>')

-- Keep cursor center when search
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')
nmap('J', 'mzJ`z')

-- Make life more easier
nmap('H', '^')
omap('H', '^')
xmap('H', '^')
omap('L', '$')
nmap('L', '$')
xmap('L', '$')

-- Undo break points
imap('.', '.<c-g>u')
imap('[', '[<c-g>u')
imap('!', '!<c-g>u')
imap('?', '?<c-g>u')

-- Keep visual mode indenting
vmap('<', '<gv')
vmap('>', '>gv')

-- Moving line
nmap('<leader>j', '<cmd>m .+1<cr>==')
nmap('<leader>k', '<cmd>m .-2<cr>==')
-- imap('<leader>j', '<esc><cmd>m .+1<cr>==gi')
-- imap('<leader>k', '<esc><cmd>m .-2<cr>==gi')
vmap('<leader>j', ":m '>+1<cr>gv=gv")
vmap('<leader>k', ":m '<-2<cr>gv=gv")

-- Remap for dealing with word wrap
nmap('k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
nmap('j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Delete without changing the registers
mapper({ 'n', 'x' })('x', '"_x')
xmap('<leader>p', '"_dP')

-- Replace text
nmap('<leader>rr', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = false })

-- Replace text in visual mode
vmap('<leader>rr', [["zy:%s/<C-r><C-o>"/]], { silent = false })

-- Get current file path
nmap(
  '<leader>cp',
  [[:let @+=substitute(expand("%:p"), getcwd() . '/', '', '')<cr>:echo " " . @+ . " copied to clipboard 📝"<cr>]],
  { noremap = true }
)

-- Copy the content of current file to clipboard
nmap(
  '<leader>cP',
  [[:%y+<cr>:echo "Content of " . expand("%:p") . " copied to clipboard 📝"<cr>]],
  { noremap = true }
)

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
nmap('<Esc>', '<cmd>nohlsearch<cr>')

-- Diagnostic keymaps
nmap('[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
nmap(']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
nmap('<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
-- nmap('<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
tmap('<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Resizing windows, M is option key in MacOS
nmap('<M-Up>', ':resize +2<CR>')
nmap('<M-Down>', ':resize -2<CR>')
nmap('<M-Left>', ':vertical resize +2<CR>')
nmap('<M-Right>', ':vertical resize -2<CR>')

-- Prevent to used arrow keys ;)
nmap('<left>', '<cmd>echo "Use h to move ❌"<cr>')
nmap('<right>', '<cmd>echo "Use l to move ❌"<cr>')
nmap('<up>', '<cmd>echo "Use k to move ❌"<cr>')
nmap('<down>', '<cmd>echo "Use j to move ❌"<cr>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
nmap('<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
nmap('<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
nmap('<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
nmap('<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- mpc for Music Player Daemon (MPD)
-- silent to prevent neovim display message after command executed
-- nmap('<leader>mn', ':mpc next<cr>:echo " Next song ♫ "<cr>')
--
-- nmap('<leader>mb', ':mpc prev<cr>:echo " Back song ♫ "<cr>')
-- nmap('<leader>mp', ':mpc play<cr>')
-- nmap('<leader>mP', ':mpc pause<cr>')
-- nmap('<leader>mS', ':mpc stop<cr>')

-- Markdown preview
nmap('<leader>mp', ':Glow<cr>')
