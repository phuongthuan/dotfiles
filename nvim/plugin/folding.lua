vim.pack.add({
  'https://github.com/kevinhwang91/promise-async',
  'https://github.com/kevinhwang91/nvim-ufo',
})

local nmap = require('utils').nmap

vim.o.foldenable = true
vim.o.foldcolumn = '0' -- default is 1
vim.o.foldlevelstart = 99
-- vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- vim.o.foldmethod = 'manual' -- Default fold method (change as needed)
-- vim.o.foldmethod = 'manual' -- Default fold method (change as needed)

local ufo = require('ufo')
ufo.setup({
  provider_selector = function(_, _, _)
    return { 'treesitter', 'indent' }
  end,
  open_fold_hl_timeout = 0, -- Disable highlight timeout after opening
})

-- za to fold at cursor location is already enabled
nmap('zR', ufo.openAllFolds, { desc = 'Open All Folds' })
nmap('zM', ufo.closeAllFolds, { desc = 'Close All Folds' })
