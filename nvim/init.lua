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
vim.loader.enable()

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
require("plugins/telescope") -- search tool
require("plugins/colorizer") -- colorizer
require("plugins/harpoon") -- harpoon
require("plugins/fugitive") -- git client
require("plugins/mason") -- LSP manager
require("plugins/devicons") -- icons
require("plugins/copilot") -- copilot
require("plugins/comment") -- comment utils

require("colorschemes/gruvbox")

require("lsp")

print("Loaded in " .. fn.printf("%.3f", fn.reltimefloat(fn.reltime(start_time))) .. " seconds.")
