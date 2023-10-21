require("gruvbox").setup({
	bold = false,
	italic = {
		strings = true,
		operators = true,
		comments = true,
	},
	invert_selection = false,
	contrast = "hard",
})

vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
