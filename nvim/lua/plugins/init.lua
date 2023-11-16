local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Required
	"nvim-lua/plenary.nvim",
	"nvim-lua/popup.nvim",

	-- Color schemes
	"ellisonleao/gruvbox.nvim",

	-- LSP
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"nvimtools/none-ls.nvim",

	-- Autocompletion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",

	-- Copilot
	{ "zbirenbaum/copilot.lua", cmd = "Copilot", event = "InsertEnter" },
	{ "zbirenbaum/copilot-cmp", dependencies = { "zbirenbaum/copilot.lua" } },

	-- Snippets
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",

	-- Markdown
	"jxnblk/vim-mdx-js",
	"plasticboy/vim-markdown",

	-- Git
	"lewis6991/gitsigns.nvim",
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"junegunn/gv.vim",

	-- Code highlighting, colors, look and feel
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-refactor",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"RRethy/nvim-treesitter-endwise",

	-- UI
	"onsails/lspkind-nvim",
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", lazy = true } },
	"norcalli/nvim-colorizer.lua",
	"lukas-reineke/indent-blankline.nvim",
	{ "nvim-tree/nvim-tree.lua", version = "nightly" },
	{
		"j-hui/fidget.nvim",
		version = "legacy",
		event = "LspAttach",
		config = function()
			require("fidget").setup({})
		end,
	},

	-- Utilies
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({ disable_filetype = { "TelescopePrompt", "vim" } })
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
	"vimwiki/vimwiki",
	"wakatime/vim-wakatime",
	"tpope/vim-commentary",
	"mattn/emmet-vim",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"ThePrimeagen/harpoon",
	{ "mg979/vim-visual-multi", branch = "master" },
	{
		"kylechui/nvim-surround",
		version = "*",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	},

	-- Telescope
	"nvim-telescope/telescope.nvim",
	"nvim-telescope/telescope-fzy-native.nvim",
	"nvim-telescope/telescope-file-browser.nvim",
})
