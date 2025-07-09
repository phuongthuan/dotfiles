return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  --- @module 'which-key'
  --- @class wk.Opts
  opts = {
    preset = 'helix',
    delay = 500,
    spec = {
      {
        mode = 'n',
        { '<leader>a', group = ' 󱚝 ' },
        { '<leader>ag', group = ' Prompt 󱚝 ' },
        { '<leader>b', group = ' Buffers' },
        { '<leader>c', group = ' Coding' },
        { '<leader>f', group = ' Files' },
        { '<leader>p', group = ' Search' },
        { '<leader>go', group = ' Open URL' },
        { '<leader>gy', group = ' Copy URL' },
        { '<leader>u', group = ' Options' },
        { '<leader>g', group = ' Git  ' },
        { '<leader>h', group = ' Git  ' },
      },
    },
    icons = {
      mappings = false,
      breadcrumb = '»',
      separator = ' ▎ ',
    },
    show_help = false,
    sort = { 'local', 'order', 'alphanum', 'mod' },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
