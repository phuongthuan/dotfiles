--[[

  ██╗███╗   ██╗██╗████████╗██╗     ██╗   ██╗ █████╗
  ██║████╗  ██║██║╚══██╔══╝██║     ██║   ██║██╔══██╗
  ██║██╔██╗ ██║██║   ██║   ██║     ██║   ██║███████║
  ██║██║╚██╗██║██║   ██║   ██║     ██║   ██║██╔══██║
  ██║██║ ╚████║██║   ██║██╗███████╗╚██████╔╝██║  ██║
  ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
                  Neovim init file
                Author: Thuan Nguyen
            https://github.com/phuongthuan
--]]

local fn = vim.fn
local start_time = fn.reltime()

-- Speed up Lua modules
require('impatient')

-- Always map leader first
vim.g.mapleader = ' '

-- Core
require('options')                  -- options
require('keymaps')                  -- keymaps
require('plugins')                  -- plugin manager
require('lsp')                      -- LSP settings
require('lsp/html')

-- Plugins
require('plugins/nvim-tree')	      -- file explorer
require('plugins/lualine')          -- statusline
require('plugins/cmp')              -- autocomplete
require('plugins/gitsigns')         -- git checking tool
require('plugins/vim-starify')      -- start screen
require('plugins/treesitter')       -- improve code highlighting
require('plugins/vim-sneak')        -- better jump word
require('plugins/emmet-vim')        -- emmet HTML
require('plugins/telescope')        -- search tool
require('plugins/autopairs')        -- auto autopairs
require('plugins/lspkind')          -- icon types
require('plugins/vimwiki')          -- personal note
require('plugins/colorizer')        -- colorizer
require('plugins/harpoon')          -- harpoon
require('plugins/fugitive')         -- best Git client for vim

print('Loaded in ' .. fn.printf('%.3f', fn.reltimefloat(fn.reltime(start_time))) .. ' seconds.')
