return {
  -- Git plugins
  'tpope/vim-fugitive',
  'junegunn/gv.vim',
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      {
        '<leader>U',
        '<cmd>UndotreeToggle<cr>',
        desc = 'Toggle Undo tree',
      },
    },
  },

  'tpope/vim-rhubarb',
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

  { -- Blazingly fast movements
    'ggandor/leap.nvim',
    keys = { 's', 'S', 'gs' },
    config = function()
      require('leap').set_default_keymaps()
    end,
  },
  -- {
  --   'folke/flash.nvim',
  --   event = 'VeryLazy',
  --   ---@type Flash.Config
  --   opts = {},
  --   -- stylua: ignore
  --   keys = {
  --     { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  --   },
  -- },
  -- {
  --   'folke/trouble.nvim',
  --   opts = {},
  --   cmd = 'Trouble',
  --   keys = {
  --     {
  --       '<leader>xx',
  --       '<cmd>Trouble diagnostics toggle<cr>',
  --       desc = 'Diagnostics (Trouble)',
  --     },
  --     {
  --       '<leader>xX',
  --       '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
  --       desc = 'Buffer Diagnostics (Trouble)',
  --     },
  --   },
  -- },
  { 'nvim-notify', opts = { background_colour = '#000000' } },
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
