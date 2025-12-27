return {
  'leath-dub/snipe.nvim',
  enabled = false,
  keys = {
    {
      'gb',
      function()
        require('snipe').open_buffer_menu()
      end,
      desc = 'Open Snipe buffer menu',
    },
  },
  opts = {
    ui = { position = 'center' },
    navigate = {
      open_vsplit = '<C-v>',
      open_split = '<C-h>',
    },
  },
}
