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
		height = 0.5, -- Height of the terminal window
		width = 0.5, -- Width of the terminal window
		x = 0.5, -- X axis of the terminal window
		y = 0.5,
	},
})

-- Example keybindings
map("n", "<leader>t", '<CMD>lua require("FTerm").toggle()<CR>')
map("t", "<leader>t", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
