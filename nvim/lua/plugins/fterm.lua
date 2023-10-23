local map = vim.keymap.set

local status, fterm = pcall(require, "fterm")
if not status then
	return
end

-- Plugin: FTerm.nvim
--- https://github.com/numToStr/FTerm.nvim

fterm.setup({
	border = "single",
	blend = 1,
	dimensions = {
		height = 0.5,
		width = 0.5,
		x = 0.5,
		y = 0.5,
	},
})

-- Example keybindings
map("n", "<leader>t", '<cmd>lua require("FTerm").toggle()<CR>')
map("t", "<leader>t", '<C-\\><C-n><cmd>lua require("FTerm").toggle()<CR>')
map("t", "<leader>T", '<C-\\><C-n><cmd>lua require("FTerm").exit()<CR>')
