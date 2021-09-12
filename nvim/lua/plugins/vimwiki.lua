-----------------------------------------------------------
-- Vimwiki
-----------------------------------------------------------

-- Plugin: vimwiki
--- https://github.com/vimwiki/vimwiki

-- local g = vim.g
local cmd = vim.cmd

-- g.vimwiki_list = {path = '~/vimwiki/', syntax = 'markdown', ext = '.md'}

cmd [[ let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}] ]]
