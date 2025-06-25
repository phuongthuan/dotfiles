return {
  'uga-rosa/translate.nvim',
  keys = {
    {
      '<leader>tt',
      '<cmd>Translate Vi<cr>',
      mode = { 'n', 'v' },
      desc = 'Translate Selected Text',
      silent = true,
    },
  },
}
