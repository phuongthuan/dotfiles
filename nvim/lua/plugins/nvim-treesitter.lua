-----------------------------------------------------------
-- Treesitter
-----------------------------------------------------------

-- Plugin: nvim-treesitter
--- https://github.com/nvim-treesitter/nvim-treesitter

require('nvim-treesitter.configs').setup({
    indent = { enable = true },
    highlight = { enable = true },
    ensure_installed = {
      "javascript",
      "typescript",
      "tsx",
      "lua",
      "json",
      "jsonc",
      "yaml",
      "scss"
    },
    -- plugins
    autopairs = { enable = true },
    textsubjects = {
      enable = true,
      keymaps = {
        ["."] = "textsubjects-smart",
        [";"] = "textsubjects-container-outer",
      },
    },
    autotag = {
       enable = true,
    },
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
