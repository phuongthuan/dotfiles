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
require("impatient").enable_profile()

-- Always map leader first
vim.g.mapleader = " "

-- Core
require("options")
require("remaps")

-- Plugins
require("plugins")
require("plugins/nvim-tree") -- file explorer
require("plugins/lualine") -- statusline
require("plugins/cmp") -- autocomplete
require("plugins/gitsigns") -- git checking tool
require("plugins/treesitter") -- code highlighting
require("plugins/vim-sneak") -- better jump word
require("plugins/telescope") -- search tool
require("plugins/lspkind") -- icon types
require("plugins/vimwiki") -- personal note
require("plugins/colorizer") -- colorizer
require("plugins/harpoon") -- harpoon
require("plugins/fugitive") -- best Git client for vim
require("plugins/mason") -- LSP manager
require("plugins/nvim-web-devicons")
require("plugins/fidget") -- progress for lsp
require("plugins/fterm") -- terminal

require("colorschemes/gruvbox")

require("lsp")

print("Loaded in " .. fn.printf("%.3f", fn.reltimefloat(fn.reltime(start_time))) .. " seconds.")
