require("gruvbox").setup({
	bold = false,
	italic = {
		strings = true,
		operators = true,
		comments = true,
	},
	invert_selection = false,
	contrast = "soft",
  transparent_mode = true
})

vim.o.background = "dark"
-- vim.g.gruvbox_transparent_bg = 1
vim.cmd.colorscheme("gruvbox")
