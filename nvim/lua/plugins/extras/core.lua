return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-endwise',

  'onsails/lspkind-nvim',

  { 'mg979/vim-visual-multi', branch = 'master' },
  {
    'kylechui/nvim-surround',
    event = { 'BufReadPost', 'BufNewFile' },
    config = true,
  },
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
        ':Translate Vi<CR>',
        mode = { 'n', 'v' },
        desc = 'Translate under cursor and selected text',
        silent = true,
      },
    },
  },
}
