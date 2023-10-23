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
vim.g.gruvbox_transparent_bg = 1
vim.cmd([[colorscheme gruvbox]])
