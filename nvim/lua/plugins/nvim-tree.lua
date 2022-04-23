local g = vim.g
local map = require('utils').map

-- Plugin: nvim-tree
--- https://github.com/kyazdani42/nvim-tree.lua

g.nvim_tree_git_hl = 1
g.nvim_tree_width_allow_resize  = 1
g.nvim_tree_special_files = {'README.md', 'Makefile', 'MAKEFILE'}

g.nvim_tree_show_icons = {
  git = 0,
  folders = 0,
  files = 1
}

g.nvim_tree_icons = {
  -- default = '',
  symlink = '',
  folder = {
    symlink = '',
  },
}

require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  diagnostics         = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  view = {
    width = 40,
    height = 30,
    side = 'left',
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {}
    }
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  filters = {
    dotfiles = false,
    custom = { '^.git$', 'node_modules/', '.DS_Store' },
    exclude = { '.env', 'application.yml' },
  },
}


-- Keymaps
map('n', '<C-b>', ':NvimTreeToggle<CR>')
map('n', '<C-f>', ':NvimTreeFindFile<CR>')
