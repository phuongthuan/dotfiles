return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'c',
      'css',
      'csv',
      'bash',
      'diff',
      'html',
      'lua',
      'luadoc',
      'gitcommit',
      'gitignore',
      'markdown',
      'markdown_inline',
      'vim',
      'vimdoc',
      'javascript',
      'typescript',
      'tsx',
      'json',
      'ruby',
      'graphql',
      'go',
      'gomod',
      'regex',
      'scss',
      'yaml',
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    endwise = { enable = true },
  },
  config = function(_, opts)
    -- Prefer git instead of curl in order to improve connectivity in some environments
    require('nvim-treesitter.install').prefer_git = true

    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)
  end,
}
