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
      "css",
      "scss",
      "ruby",
      "html",
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
    -- enable module 'nvim-ts-context-commentstring' in treesitter
    context_commentstring = {
      enable = true,
      config = {
        javascript = {
          __default = '// %s',
          jsx_element = '{/* %s */}',
          jsx_fragment = '{/* %s */}',
          jsx_attribute = '// %s',
          comment = '// %s'
        }
      }
    }
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
