local autocmd = vim.api.nvim_create_autocmd
local nmap = require('core.utils').mapper_factory('n')

local group = vim.api.nvim_create_augroup('UserConfig', { clear = true })

autocmd('TextYankPost', {
  group = group,
  pattern = '*',
  callback = function()
    vim.hl.on_yank({ higroup = 'IncSearch', timeout = 40 })
  end,
  desc = 'Highlight Text On Yank',
})

autocmd('WinEnter', {
  group = group,
  pattern = '*',
  callback = function()
    vim.wo.cursorline = true
  end,
  desc = 'Highlight Cursorline On Active Window',
})

autocmd('FileType', {
  group = group,
  pattern = {
    'vim',
    'man',
    'help',
    'checkhealth',
    'lspinfo',
    'query',
    'startuptime',
    'fugitive',
  },
  callback = function(e)
    -- Map q to exit in non-filetype buffers
    vim.bo[e.buf].buflisted = false
    nmap('q', ':q<CR>', { buffer = e.buf })
  end,
  desc = 'Maps q to exit on non-filetypes',
})

autocmd({ 'BufRead', 'BufNewFile' }, {
  group = group,
  pattern = { '*.env', '.env.*' },
  callback = function()
    vim.opt_local.filetype = 'sh'
  end,
  desc = 'Auto set filetype for .env and .env.* files',
})

-- Enable spellcheck for certain files
-- autocmd('FileType', {
--   group = autocmds_group,
--   pattern = {
--     'gitcommit',
--     'markdown',
--     'txt',
--   },
--   callback = function()
--     vim.opt_local.spell = true
--     vim.opt_local.spelllang = 'en'
--   end,
--   desc = 'Enable spellcheck for certain files',
-- })

autocmd('BufWritePre', {
  group = group,
  pattern = '*',
  command = [[%s/\s\+$//e]],
  desc = 'Remove Trailing Spaces',
})
