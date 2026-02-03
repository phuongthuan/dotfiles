return {
  'nvim-lua/plenary.nvim',
  'NMAC427/guess-indent.nvim',
  { 'windwp/nvim-ts-autotag', opts = {} },
  { 'isak102/ghostty.nvim', ft = 'conf', opts = {} },
  {
    'szw/vim-maximizer',
    keys = {
      { '<leader>sm', '<cmd>MaximizerToggle<CR>', desc = 'Maximize/minimize a split', silent = true },
    },
  },
  require('core.gh-cli').setup(),
}
