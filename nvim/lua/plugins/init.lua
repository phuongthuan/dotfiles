return {
  'nvim-lua/plenary.nvim',
  'tpope/vim-endwise',
  'NMAC427/guess-indent.nvim',
  { 'mg979/vim-visual-multi', branch = 'master' },
  { 'windwp/nvim-ts-autotag', opts = {} },
  {
    'szw/vim-maximizer',
    keys = {
      { '<leader>sm', '<cmd>MaximizerToggle<CR>', desc = 'Maximize/minimize a split', silent = true },
    },
  },
}
