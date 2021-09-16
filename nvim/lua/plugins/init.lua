-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

vim.cmd 'packadd paq-nvim'            -- load paq
local paq = require('paq-nvim').paq   -- import module with `paq` function

-- Plugin manager: paq-nvim
--- https://github.com/savq/paq-nvim

-- Add packages
require 'paq' {
  'savq/paq-nvim';  -- let paq manage itself

  -- LSP
  'neovim/nvim-lspconfig';
  'hrsh7th/nvim-cmp'; -- autocompletion
  'hrsh7th/cmp-buffer';
  'hrsh7th/cmp-vsnip';
  'hrsh7th/cmp-path';
  'hrsh7th/cmp-nvim-lsp';
  'hrsh7th/cmp-nvim-lua';
  'glepnir/lspsaga.nvim';
  'onsails/lspkind-nvim';

  -- UI
  'morhetz/gruvbox';  -- theme

  'wakatime/vim-wakatime';
  'hoob3rt/lualine.nvim';
  'mhinz/vim-startify';
  'kyazdani42/nvim-tree.lua';
  'kyazdani42/nvim-web-devicons';
  'Yggdroot/indentLine';
  'norcalli/nvim-colorizer.lua';

  -- Markdown
  'jxnblk/vim-mdx-js';
  'godlygeek/tabular';
  'plasticboy/vim-markdown';

  -- Git
  'nvim-lua/plenary.nvim';
  'lewis6991/gitsigns.nvim';

  -- Snippets
  'hrsh7th/vim-vsnip';
  'hrsh7th/vim-vsnip-integ';

  -- Utilies
  'windwp/nvim-autopairs';
  'vimwiki/vimwiki';
  'liuchengxu/vista.vim';
  'justinmk/vim-sneak';
  'tpope/vim-surround';
  'mattn/emmet-vim';
  'b3nj5m1n/kommentary';

  -- Code Highlight
  'nvim-treesitter/nvim-treesitter';
  {'styled-components/vim-styled-components', branch="main"};

  -- Telescope requirement
  'nvim-lua/popup.nvim';
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';
  'nvim-telescope/telescope-fzy-native.nvim';
}

