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
  'hrsh7th/cmp-copilot';
  'onsails/lspkind-nvim';

  -- UI
  'morhetz/gruvbox';  -- best colortheme of all time :)

  'wakatime/vim-wakatime';
  'hoob3rt/lualine.nvim';
  'mhinz/vim-startify';
  'kyazdani42/nvim-web-devicons';
  'kyazdani42/nvim-tree.lua';
  'Yggdroot/indentLine';
  'norcalli/nvim-colorizer.lua';

  -- Markdown
  'jxnblk/vim-mdx-js';
  'godlygeek/tabular';
  'plasticboy/vim-markdown';

  -- Git
  'lewis6991/gitsigns.nvim';
  'tpope/vim-fugitive';

  -- Snippets
  'hrsh7th/vim-vsnip';
  'hrsh7th/vim-vsnip-integ';

  -- Utilies
  'windwp/nvim-autopairs';
  'vimwiki/vimwiki';
  'liuchengxu/vista.vim';
  'justinmk/vim-sneak';
  'tpope/vim-surround';
  'tpope/vim-commentary';
  'mattn/emmet-vim';
  'JoosepAlviste/nvim-ts-context-commentstring';
  'ThePrimeagen/harpoon';
  {'mg979/vim-visual-multi', branch="master"};
  'github/copilot.vim';
  'lewis6991/impatient.nvim'; -- speed up loading Lua modules

  -- Code Highlight
  'nvim-treesitter/nvim-treesitter';
  {'styled-components/vim-styled-components', branch="main"};

  -- Telescope requirement
  'nvim-lua/popup.nvim';
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';
  'nvim-telescope/telescope-fzy-native.nvim';
  'nvim-telescope/telescope-file-browser.nvim';
}

