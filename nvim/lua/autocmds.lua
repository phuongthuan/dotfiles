local autocmd = vim.api.nvim_create_autocmd
local nnoremap = require('core.utils').mapper_factory('n')

local my_local_group = vim.api.nvim_create_augroup('UserConfig', {})

autocmd('TextYankPost', {
  group = my_local_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = 'Highlight text on yank (copy)',
})

autocmd('WinEnter', {
  group = my_local_group,
  pattern = '*',
  callback = function()
    vim.wo.cursorline = true
    vim.wo.colorcolumn = '80'
  end,
  desc = 'Highlight cursorline and colorcolumn on active window',
})

autocmd('FileType', {
  group = my_local_group,
  pattern = {
    'checkhealth',
    'help',
    'lspinfo',
    'qf',
    'query',
    'startuptime',
    'tsplayground',
  },
  callback = function(e)
    -- Map q to exit in non-filetype buffers
    vim.bo[e.buf].buflisted = false
    nnoremap('q', ':q<CR>', { buffer = e.buf })
  end,
  desc = 'Maps q to exit on non-filetypes',
})
