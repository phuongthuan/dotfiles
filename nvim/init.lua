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
require('settings')                 -- settings
require('keymaps')                  -- keymaps
require('plugins')                  -- plugin manager
require('lsp')                      -- LSP settings
require('lsp/html')

-- Plugins
require('plugins/nvim-tree')	      -- file explorer
require('plugins/lualine')          -- statusline
require('plugins/nvim-cmp')         -- autocomplete
require('plugins/gitsigns')         -- git checking tool
require('plugins/vim-starify')      -- start screen
require('plugins/nvim-treesitter')  -- improve code highlighting
require('plugins/vim-sneak')        -- better jump word
require('plugins/emmet-vim')        -- Emmet HTML
require('plugins/vsnip')            -- snippets
require('plugins/telescope')        -- search tool
require('plugins/nvim-autopairs')   -- auto autopairs
require('plugins/lspkind')          -- icon types
require('plugins/vimwiki')          -- personal note
require('plugins/colorizer')        -- colorizer
require('plugins/harpoon')          -- harpoon
require('plugins/vim-fugitive')     -- best Git client for vim

print('Loaded in ' .. fn.printf('%.3f', fn.reltimefloat(fn.reltime(start_time))) .. ' seconds.')
