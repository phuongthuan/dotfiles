-- local status, copilot = pcall(require, "copilot")
-- if not status then
-- 	return
-- end
-- copilot

-- -- Plugin: copilot.lua
-- --- https://github.com/zbirenbaum/copilot.lua

require("copilot").setup({
	suggestion = { enabled = true },
	panel = { enabled = true },
	copilot_node_command = vim.fn.expand("$HOME") .. "/.nvm/versions/node/v18.14.1/bin/node",
})

require("copilot_cmp").setup()
