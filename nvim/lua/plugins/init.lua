local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP =
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	print("Installing packer close and re-open Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Required
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")

	-- Color schemes
	use("ellisonleao/gruvbox.nvim")

	-- LSP
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim")

	-- Autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("saadparwaiz1/cmp_luasnip")

	-- Snippets
	use("L3MON4D3/LuaSnip")

	-- Markdown
	use("jxnblk/vim-mdx-js")
	use("plasticboy/vim-markdown")

	-- Git
	use("lewis6991/gitsigns.nvim")
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("junegunn/gv.vim")
	-- use 'ThePrimeagen/git-worktree.nvim'

	-- Code highlighting, colors, look and feel
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
		end,
	})
	-- use 'nvim-treesitter/nvim-treesitter-refactor'
	-- use 'nvim-treesitter/nvim-treesitter-textobjects'
	use("RRethy/nvim-treesitter-endwise")

	-- UI
	use("onsails/lspkind-nvim")
	use("nvim-tree/nvim-web-devicons")
	use("nvim-lualine/lualine.nvim")
	use("norcalli/nvim-colorizer.lua")
	use("lukas-reineke/indent-blankline.nvim")
	use({ "nvim-tree/nvim-tree.lua", tag = "nightly" })
	use("j-hui/fidget.nvim")

	-- Utilies
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({ disable_filetype = { "TelescopePrompt", "vim" } })
		end,
	})
	use({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	})
	use("vimwiki/vimwiki")
	use("wakatime/vim-wakatime")
	use("justinmk/vim-sneak")
	use("tpope/vim-commentary")
	use("mattn/emmet-vim")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("ThePrimeagen/harpoon")
	use({ "mg979/vim-visual-multi", branch = "master" })
	use("lewis6991/impatient.nvim") -- speed up loading Lua modules
	use({
		"kylechui/nvim-surround",
		tag = "*",
		config = function()
			require("nvim-surround").setup({})
		end,
	})

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-fzy-native.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
