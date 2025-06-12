local env = require('core.env')
local mapper = require('core.utils').mapper_factory

local nmap = mapper('n')
local vmap = mapper('v')
local imap = mapper('i')
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

-- Open EH configuration
nmap('<leader>eh', ':e ' .. env.EH_CONFIG_FILE .. '<cr>', { desc = 'Open EH configuration' })
nmap('<leader>sc', ':e ' .. env.SECRET_ENV_FILE .. '<cr>', { desc = 'Open Secret configuration' })

-- No need to keep holding shift
nmap(';', ':', { silent = false })
vmap(';', ':', { silent = false })

-- Save current buffer
nmap('<leader>s', ':w<cr>:echo "Saved current file ✔"<cr>')

-- Save all loaded buffers
nmap('<leader>S', ':wa<cr>:echo "Saved all files ✔"<cr>')

-- :wq
nmap('<leader>w', ':wq<cr>:echo "Git commit created ✔"<cr>')

-- Map Esc to jk
imap('jk', '<Esc>', { noremap = true })

-- Z{symbol} to select inside
nmap('Z', 'yi')

-- Buffers next and prev
nmap('<tab>', ':bp<cr>')
nmap('<S-tab>', ':bn<cr>')

-- Switch between last two files
nmap('<BS>', '<C-^>')

-- Exit Neovim ❌
nmap('<leader>q', ':q<cr>')

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

-- Get current file path
nmap(
  '<leader>cp',
  [[:let @+=substitute(expand("%:p"), getcwd() . '/', '', '')<cr>:echo " " . @+ . " copied to clipboard ✔"<cr>]],
  { desc = 'Copy current file path', noremap = true }
)

-- Copy the content of current file to clipboard
nmap(
  '<leader>cP',
  [[:%y+<cr>:echo "Content copied to clipboard ✔"<cr>]],
  { desc = 'Copy current file content', noremap = true }
)

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
nmap('<Esc>', '<cmd>nohlsearch<cr>')

-- Resizing windows, M is option key in MacOS
nmap('<M-Up>', ':resize +2<CR>')
nmap('<M-Down>', ':resize -2<CR>')
nmap('<M-Left>', ':vertical resize +2<CR>')
nmap('<M-Right>', ':vertical resize -2<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
nmap('<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
nmap('<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
nmap('<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
nmap('<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

nmap('<leader>ts', function()
  ---@diagnostic disable-next-line: undefined-field
  local new_state = not vim.opt_local.spell:get()
  vim.opt_local.spell = new_state
  if new_state then
    vim.opt_local.spelllang = 'en'
  end
end, { desc = 'Toggle Spell Checking' })

nmap('<leader>tl', function()
  local new_state = not vim.o.number
  vim.o.number = new_state
  vim.notify(new_state and 'Line number enabled ✔' or 'Line number disabled ✔', vim.log.levels.INFO)
end, { desc = 'Toggle Line Number' })

nmap('<leader>rt', function()
  local file = vim.api.nvim_buf_get_name(0)
  vim.notify('🧪 Run test: ' .. file, vim.log.levels.INFO)
  vim.system({
    'zsh',
    '-ic',
    string.format("tmux new-window -n test 'yarn test %s; exec zsh'", file),
  })
end, { desc = 'Run test for current file' })
