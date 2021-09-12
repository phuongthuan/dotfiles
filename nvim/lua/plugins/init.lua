-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: paq-nvim
--- https://github.com/savq/paq-nvim

vim.cmd 'packadd paq-nvim'            -- load paq
local paq = require('paq-nvim').paq   -- import module with `paq` function

-- Add packages
require 'paq' {
  'savq/paq-nvim';  -- let paq manage itself

  -- LSP
  'hrsh7th/nvim-cmp'; -- autocompletion
  'hrsh7th/cmp-nvim-lsp';
  'neovim/nvim-lspconfig';
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

  -- Markdown
  'jxnblk/vim-mdx-js';
  'godlygeek/tabular';
  'plasticboy/vim-markdown';

  -- Git
  'nvim-lua/plenary.nvim';
  'lewis6991/gitsigns.nvim';

  -- Snippets
  'SirVer/ultisnips';
  'mlaursen/vim-react-snippets';
  'hrsh7th/vim-vsnip';

  -- Utilies
  'windwp/nvim-autopairs';
  'vimwiki/vimwiki';
  'liuchengxu/vista.vim';
  'justinmk/vim-sneak';
  'tpope/vim-surround';
  'tpope/vim-commentary';
  'mattn/emmet-vim';

  -- Code Highlight
  'nvim-treesitter/nvim-treesitter';
  {'styled-components/vim-styled-components', branch="main"};

  -- Telescope requirement
  'nvim-lua/popup.nvim';
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';
  'nvim-telescope/telescope-fzy-native.nvim';
}

