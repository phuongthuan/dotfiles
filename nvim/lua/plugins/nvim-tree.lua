local map = vim.keymap.set

-- Plugin: nvim-tree
--- https://github.com/kyazdani42/nvim-tree.lua

--- Migrate guide: https://github.com/nvim-tree/nvim-tree.lua/issues/674

require'nvim-tree'.setup {
  disable_netrw       = false,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
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
    side = 'right',
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
  renderer = {
    highlight_git = true,
    special_files = {'README.md', 'Makefile', 'MAKEFILE'},
    icons = {
      glyphs = {
        -- default = '',
        symlink = '',
        folder = {
          symlink = '',
        },
      },
      show = {
        git = false,
        folder = false,
        folder_arrow = false,
        file = true,
      }
    }
  }
}

-- Keymaps
map('n', '<C-b>', ':NvimTreeToggle<CR>')
map('n', '<C-f>', ':NvimTreeFindFile<CR>')
