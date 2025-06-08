return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-endwise', -- Adding end after if, do, def, function, etc
  { 'mg979/vim-visual-multi', branch = 'master' },
  { 'windwp/nvim-ts-autotag', opts = {} },
  {
    'ggandor/leap.nvim',
    keys = { 's', 'S', 'gs' },
    config = function()
      require('leap').set_default_keymaps()
    end,
  },
  {
    'uga-rosa/translate.nvim',
    keys = {
      {
        '<leader>tt',
        '<cmd>Translate Vi<cr>',
        mode = { 'n', 'v' },
        desc = 'Translate under cursor and selected text',
        silent = true,
      },
    },
  },
  {
    'szw/vim-maximizer',
    keys = {
      { '<leader>sm', '<cmd>MaximizerToggle<CR>', desc = 'Maximize/minimize a split', silent = true },
    },
  },
}
