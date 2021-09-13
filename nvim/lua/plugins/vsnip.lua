-----------------------------------------------------------
-- Vim Snippets
-----------------------------------------------------------

-- Plugin: vim-vsnip
--- https://github.com/junegunn/fzf.vim

local g = vim.g

g.vsnip_filetypes = {
  javascriptreact = { "javascript" },
  typescriptreact = { "typescript" },
}

vim.cmd [[
  imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
  smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
]]
