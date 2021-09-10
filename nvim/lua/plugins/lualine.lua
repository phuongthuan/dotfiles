-----------------------------------------------------------
-- Statusline configuration file
-----------------------------------------------------------

-- Plugin: lualine
--- https://github.com/hoob3rt/lualine.nvim

local lualine = require('lualine')

lualine.setup {
  options = {
    theme = 'gruvbox',
    icons_enabled = true,
    extensions = {'nvim-tree'},
  };
}
