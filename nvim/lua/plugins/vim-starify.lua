-----------------------------------------------------------
-- Vim starify
-----------------------------------------------------------

local g = vim.g

g.startify_session_dir = '~/.config/nvim/session'
g.startify_session_autoload = 1
g.startify_files_number = 6

-- g.startify_lists = {
--   { 'type' = 'sessions', header = 'Sessions' },
--   { 'type' = 'bookmarks', header = 'Bookmarks' }
-- }

-- g.startify_bookmarks = {
--   z = '~/.zshrc',
--   w = '~/vimwiki',
-- }

-- vim.cmd [[
-- let g:startify_lists = [
--       \ { 'type': 'files',     'header': ['   MRU']            },
--       \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
--       \ { 'type': 'sessions',  'header': ['   Sessions']       },
--       \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
--       \ ]
-- let g:startify_bookmarks = [
--       \ {'z': '~/.zshrc'},
--       \ {'w': '~/vimwiki'},
--       \ {'i': '~/.config/nvim/init.vim'},
--       \ '~/Programming/Practices',
--       \ ]
-- ]]

