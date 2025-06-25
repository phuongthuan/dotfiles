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
}
