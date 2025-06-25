return {
  'nvim-lua/plenary.nvim',
  'NMAC427/guess-indent.nvim',
  { 'windwp/nvim-ts-autotag', opts = {} },
  {
    'szw/vim-maximizer',
    keys = {
      { '<leader>sm', '<cmd>MaximizerToggle<CR>', desc = 'Maximize/minimize a split', silent = true },
    },
  },
  {
    'sphamba/smear-cursor.nvim',
    opts = {
      smear_between_buffers = false,
      cursor_color = '#fbf1c7',
      smear_to_cmd = false,
      -- stiffness = 0.5,
      -- trailing_stiffness = 0.5,
    },
  },
}
