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

----------------------------------------------------------
-- Import Lua modules
----------------------------------------------------------

-- Core
require('settings')                 -- settings
require('keymaps')                  -- keymaps
require('plugins')                  -- plugin manager
require('lsp')                      -- LSP settings

-- Plugins
require('plugins/nvim-tree')	      -- file manager
require('plugins/lualine')          -- statusline
require('plugins/nvim-cmp')         -- autocomplete
require('plugins/gitsigns')         --
require('plugins/vim-starify')      -- Beautify start screen
require('plugins/nvim-treesitter')  -- tree-sitter interface
require('plugins/vim-sneak')
require('plugins/emmet-vim')        -- Emmet HTML
require('plugins/vista')            -- tag viewer
require('plugins/telescope')
require('plugins/nvim-autopairs')

