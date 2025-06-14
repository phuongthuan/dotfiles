local nmap = require('core.utils').mapper_factory('n')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'plugins' },

  require('plugins.colorscheme.gruvbox'),
  require('plugins.extras.nvim-cmp'),
  require('plugins.extras.ai'),
  require('plugins.extras.noice'),
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
