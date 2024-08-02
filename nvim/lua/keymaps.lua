local cmd = vim.cmd
local env = require('core.env')
local mapper = require('core.utils').mapper_factory

local nmap = mapper('n')
local vmap = mapper('v')
local imap = mapper('i')
local tmap = mapper('t')
local xmap = mapper('x')
local omap = mapper('o')

-- Open today note
local new_note_file = env.ICLOUD_DRIVE_OBSIDIAN_DIR
  .. '/diary/'
  .. os.date('%Y-%m-%d')
  .. '.md'

nmap(
  '<leader>td',
  ':e ' .. new_note_file .. '<cr>',
  { desc = '[T]o[D]ay note', noremap = false }
)

-- Source Neovim configuration
nmap(
  '<leader><leader>1',
  ':source '
    .. env.NVIM_CONFIG_DIR
    .. '/init.lua'
    .. '<cr>:echo " Reloaded Neovim config 🚀"<cr>'
)

-- Open file in same directory
cmd([[ nnoremap ,e :e <C-R>=expand('%:p:h') . '/'<cr> ]])

-- Open EH configuration
nmap(
  '<leader>eh',
  ':e ' .. env.EH_CONFIG_FILE .. '<cr>',
  { desc = 'Open EH configuration' }
)

-- Fast saving with <leader> and s
nmap('<leader>s', ':w<cr>:echo " Saved current buffer ✅"<cr>')

-- :wq
mapper({ 'n', 'i' })(
  '<leader>w',
  '<esc>:wq<cr>:echo " Git commit created ✅"<cr>'
)

-- Saving all working buffers
nmap('<leader>S', ':wa<cr>:echo " Saved all buffers ✅"<cr>')

-- Map Esc to jk
imap('jk', '<Esc>', { noremap = true })

-- Z{symbol} to select inside
nmap('Z', 'vi')

-- Buffers next and prev
nmap('<tab>', ':bp<cr>')
nmap('<S-tab>', ':bn<cr>')

-- Switch between last two files
nmap('<BS>', '<C-^>')

-- Close window without save
mapper({ 'n', 'i' })('<leader>q', '<esc>:q!<cr>')

-- Select all file
nmap('<leader>a', ':keepjumps normal! ggVG<cr>')

-- Prevent to used arrow keys ;)
nmap('<up>', '<nop>')
nmap('<down>', '<nop>')
nmap('<left>', '<nop>')
nmap('<right>', '<nop>')

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
imap('<leader>j', '<esc><cmd>m .+1<cr>==gi')
imap('<leader>k', '<esc><cmd>m .-2<cr>==gi')
vmap('<leader>j', ":m '>+1<cr>gv=gv")
vmap('<leader>k', ":m '<-2<cr>gv=gv")

-- Remap for dealing with word wrap
nmap('k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
nmap('j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Delete without changing the registers
mapper({ 'n', 'x' })('x', '"_x')
xmap('<leader>p', '"_dP')

-- Replace multiple words
nmap('<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Get current file path
nmap(
  '<leader>cp',
  [[:let @+=substitute(expand("%:p"), getcwd() . '/', '', '')<cr>:echo " File path copied to clipboard 📝"<cr>]],
  { noremap = true }
)

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
nmap('<Esc>', '<cmd>nohlsearch<cr>')

-- Diagnostic keymaps
nmap(
  '[d',
  vim.diagnostic.goto_prev,
  { desc = 'Go to previous [D]iagnostic message' }
)
nmap(
  ']d',
  vim.diagnostic.goto_next,
  { desc = 'Go to next [D]iagnostic message' }
)
nmap(
  '<leader>e',
  vim.diagnostic.open_float,
  { desc = 'Show diagnostic [E]rror messages' }
)
-- nmap('<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
tmap('<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- nmap('<left>', '<cmd>echo "Use h to move ❌"<cr>')
-- nmap('<right>', '<cmd>echo "Use l to move ❌"<cr>')
-- nmap('<up>', '<cmd>echo "Use k to move ❌"<cr>')
-- nmap('<down>', '<cmd>echo "Use j to move ❌"<cr>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
nmap('<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
nmap('<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
nmap('<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
nmap('<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Vim-fugitive
nmap('<leader>g', ':G<cr>')
nmap('<leader>gp', ':G push origin HEAD<cr>')
nmap('<leader>gP', ':G push origin HEAD -f<cr>')
nmap('<leader>gM', ':G push origin master<cr>')
nmap('<leader>gl', ':GV<cr>')
nmap('<leader>gL', ":GV <C-R>=expand('%:p')<cr><cr>")
nmap('<leader>gm', ':G merge<Space>')

-- Resolve conflict
nmap('<leader>grc', ':Gvdiffsplit!<cr>')
-- on the Gvdiffsplit mode
-- d2o : get the left column
-- d3o : get the right column

-- mpc for Music Player Daemon (MPD)
-- silent to prevent neovim display message after command executed
nmap('<leader>mn', ':mpc next<cr>:echo " Next song ♫ "<cr>')

nmap('<leader>mb', ':mpc prev<cr>:echo " Back song ♫ "<cr>')
nmap('<leader>mp', ':mpc play<cr>')
nmap('<leader>mP', ':mpc pause<cr>')
nmap('<leader>mS', ':mpc stop<cr>')
