local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print('Installing packer close and re-open Neovim...')
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever saving the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then return end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({border = 'rounded'})
        end
    }
})

return packer.startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Required
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'

    -- Color schemes
    use 'morhetz/gruvbox'

    -- LSP
    use 'williamboman/nvim-lsp-installer'
    use 'neovim/nvim-lspconfig'

    -- Autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-cmdline'
    use 'saadparwaiz1/cmp_luasnip'

    -- Snippets
    use 'L3MON4D3/LuaSnip'

    -- Markdown
    use 'jxnblk/vim-mdx-js'
    use 'plasticboy/vim-markdown'

    -- Git
    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-fugitive';

    -- Code highlighting, colors, look and feel
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'onsails/lspkind-nvim'
    use {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}
    use 'mhinz/vim-startify'
    use 'norcalli/nvim-colorizer.lua'
    use 'kyazdani42/nvim-tree.lua'
    use 'Yggdroot/indentLine'

    -- Utilies
    use 'windwp/nvim-autopairs'
    use 'vimwiki/vimwiki'
    use 'wakatime/vim-wakatime'
    use 'justinmk/vim-sneak'
    use 'tpope/vim-commentary'
    use 'mattn/emmet-vim'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'ThePrimeagen/harpoon'
    use {'mg979/vim-visual-multi', branch = 'master'}
    use 'lewis6991/impatient.nvim' -- speed up loading Lua modules
    use({
        'kylechui/nvim-surround',
        tag = '*', -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require('nvim-surround').setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })
    -- Telescope
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then require('packer').sync() end
end)
