-- Plugin: nvim-treesitter
--- https://github.com/nvim-treesitter/nvim-treesitter

local status, ts = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
      'javascript',
      'typescript',
      'tsx',
      'lua',
      'json',
      'yaml',
      'css',
      'scss',
      'ruby',
      'html',
  },
  autotag = {
    enable = true,
  },
  autopairs = { enable = true },

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
}

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
