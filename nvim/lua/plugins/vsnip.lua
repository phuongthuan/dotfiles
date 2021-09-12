-----------------------------------------------------------
-- Vim Snippets
-----------------------------------------------------------

-- Plugin: vim-vsnip
--- https://github.com/junegunn/fzf.vim

local g = vim.g
local map = require('utils').map

g.vsnip_filetypes = {
  javascriptreact = { "javascript" },
  typescriptreact = { "typescript" },
}

map('n', '<leader>V', ':VsnipOpenVsplit<CR>')
