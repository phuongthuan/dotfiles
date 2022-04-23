local cmd = vim.cmd
local map = require('utils').map

-- Plugin: vimwiki
--- https://github.com/vimwiki/vimwiki

-- g.vimwiki_list = {path = '~/vimwiki/', syntax = 'markdown', ext = '.md'}

cmd [[ let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}] ]]

map('n', '<leader>td', ':VimwikiMakeDiaryNote<CR>', {noremap = false})
map('n', '<leader>yt', ':VimwikiMakeYesterdayDiaryNote<CR>', {noremap = false})
map('n', '<leader>tm', ':VimwikiMakeTomorrowDiaryNote<CR>', {noremap = false})
