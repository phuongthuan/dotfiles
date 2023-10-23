local status, copilot = pcall(require, "copilot")
if not status then
	return
end

-- Plugin: copilot.lua
--- https://github.com/zbirenbaum/copilot.lua

copilot.setup({
	suggestion = {
		enabled = false,
		auto_trigger = true,
		debounce = 50,
		keymap = {
			accept = "¬",
			accept_word = false,
			accept_line = false,
			next = "∆",
			prev = "˚",
			dismiss = "<C-]>",
		},
	},
	panel = {
		enabled = false,
	},
})

require("copilot_cmp").setup()
