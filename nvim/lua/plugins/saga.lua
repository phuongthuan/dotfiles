-----------------------------------------------------------
-- lspsaga.nvim
-----------------------------------------------------------

-- A light-weight lsp plugin based on neovim built-in lsp with highly a performant UI.
--- https://github.com/glepnir/lspsaga.nvim

local saga = require 'lspsaga'
local map = require('utils').map

saga.init_lsp_saga {
  code_action_icon = '💡',
  code_action_prompt = {
    enable        = true,
    sign          = true,
    sign_priority = 20,
    virtual_text  = false,
  },
  code_action_keys = { quit = {'q', '<ESC>'}, exec = '<CR>' },
  border_style     = "round",
}

map('n', 'K', ':Lspsaga hover_doc<CR>')
map('n', '<C-k>', ':Lspsaga signature_help<CR>')
map('n', 'gr', ':Lspsaga lsp_finder<CR>')
map('n', '<leader>ca', ':Lspsaga code_action<CR>')
map('n', '<leader>cd', ':Lspsaga show_line_diagnostics<CR>')
map('n', '<leader>rn', ':Lspsaga rename<CR>')

map('n', ']]', ':Lspsaga diagnostic_jump_next<CR>')
map('n', '[[', ':Lspsaga diagnostic_jump_next<CR>')

map('n', '<C-j>', ':Lspsaga diagnostic_jump_next<CR>')

-- open/close terminal
map('n', '<leader>T', ':Lspsaga open_floaterm<CR>')
vim.cmd[[tnoremap <silent> <leader>T <C-\><C-n>:Lspsaga close_floaterm<CR>]]
