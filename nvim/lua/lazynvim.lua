local nmap = require('core.utils').mapper_factory('n')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  })
end ---@diagnostic disable-next-line: undefined-field

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'plugins' },

  require('plugins.extras.core'),
  require('plugins.extras.ai'),
  require('plugins.extras.noice'),
  require('plugins.extras.incline'),
}, {
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        'tohtml',
        'gzip',
        'matchit',
        'netrw',
        'netrwFileHandlers',
        'netrwPlugin',
        'netrwSettings',
        'tar',
        'tarPlugin',
        'tutor',
        'tutor_mode_plugin',
        'zip',
        'zipPlugin',
      },
    },
  },
  ui = {
    icons = vim.g.have_nerd_font and {} or require('core.icons').ui,
  },
})

nmap('<leader>lz', '<cmd>Lazy<cr>', { desc = 'Open Lazy Manager' })
