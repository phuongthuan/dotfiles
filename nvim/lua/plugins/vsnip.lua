-----------------------------------------------------------
-- Vim Snippets
-----------------------------------------------------------

local map = require('utils').map
local cmd = vim.cmd

-- Plugin: vim-vsnip
--- https://github.com/hrsh7th/vim-vsnip

map('n', '<leader>V', ':VsnipOpen<CR>')

cmd [[
  let g:vsnip_snippet_dir = expand('~/.vsnip')
  let g:vsnip_filetypes = {}
  let g:vsnip_filetypes.javascriptreact = ['javascript']
  let g:vsnip_filetypes.typescriptreact = ['typescript']
  imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
  smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
]]
