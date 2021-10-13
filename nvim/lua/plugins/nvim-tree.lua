-----------------------------------------------------------
-- File manager configuration file
-----------------------------------------------------------

local g = vim.g
local map = require('utils').map

-- Plugin: nvim-tree
--- https://github.com/kyazdani42/nvim-tree.lua

g.nvim_tree_width = 35
g.nvim_tree_ignore = {'.git', 'node_modules', '.cache', '.DS_Store'}
g.nvim_tree_gitignore = 1
g.nvim_tree_hide_dotfiles = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_width_allow_resize  = 1
g.nvim_tree_special_files = {'README.md', 'Makefile', 'MAKEFILE'}

g.nvim_tree_show_icons = {
  git = 0,
  folders = 0,
  files = 1
}

g.nvim_tree_icons = {
  default = '',
  symlink = '',
  folder = {
    symlink = '',
  },
}

-- Keymaps
map('n', '<C-b>', ':NvimTreeToggle<CR>')
map('n', '<C-f>', ':NvimTreeFindFile<CR>')
