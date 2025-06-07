local autocmd = vim.api.nvim_create_autocmd
local user_command = vim.api.nvim_create_user_command
local nnoremap = require('core.utils').mapper_factory('n')

local autocmds_group = vim.api.nvim_create_augroup('UserConfigGroup', { clear = true })

-- AUTOCOMMANDS
autocmd('TextYankPost', {
  group = autocmds_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 40 })
  end,
  desc = 'Highlight text on yank (copy)',
})

autocmd('WinEnter', {
  group = autocmds_group,
  pattern = '*',
  callback = function()
    vim.wo.cursorline = true
    vim.wo.colorcolumn = '80'
  end,
  desc = 'Highlight cursorline and colorcolumn on active window',
})

autocmd('FileType', {
  group = autocmds_group,
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
    nnoremap('q', ':q<CR>', { buffer = e.buf })
  end,
  desc = 'Maps q to exit on non-filetypes',
})

-- Hide the `colorcolumn` when new windows opened
autocmd('WinEnter', {
  pattern = '*',
  callback = function()
    vim.wo.colorcolumn = ''
  end,
})

-- Enable spellcheck for certain files
autocmd('FileType', {
  group = autocmds_group,
  pattern = {
    'gitcommit',
    'markdown',
    'txt',
  },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en'
  end,
  desc = 'Enable spellcheck for certain files',
})

autocmd('BufWritePre', {
  group = autocmds_group,
  pattern = '*',
  command = [[%s/\s\+$//e]],
  desc = 'Remove trailing spaces',
})

-- COMMANDS
user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})

user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})
