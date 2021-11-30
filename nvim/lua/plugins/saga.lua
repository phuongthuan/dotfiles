-----------------------------------------------------------
-- lspsaga.nvim
-----------------------------------------------------------

-- A light-weight lsp plugin based on neovim built-in lsp with highly a performant UI.
--- https://github.com/glepnir/lspsaga.nvim

local saga = require('lspsaga')
local map = require('utils').map

saga.init_lsp_saga {
    code_action_prompt = {enable = true, sign = true, sign_priority = 20, virtual_text = false},
    code_action_keys = {quit = {'q', '<esc>'}, exec = '<CR>'},
    border_style = 'round'
}

map('n', 'K', ':Lspsaga hover_doc<CR>')
map('n', 'gr', ':Lspsaga lsp_finder<CR>')
map('n', '<leader>ca', ':Lspsaga code_action<CR>')
map('n', '<leader>e', ':Lspsaga show_line_diagnostics<CR>')
map('n', '<leader>rn', ':Lspsaga rename<CR>')

map('n', ']e', ':Lspsaga diagnostic_jump_next<CR>')
map('n', '[e', ':Lspsaga diagnostic_jump_prev<CR>')
