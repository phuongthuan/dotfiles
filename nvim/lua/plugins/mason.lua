local map = vim.keymap.set

local status, mason = pcall(require, "mason")
if not status then
	return
end

local status2, lspconfig = pcall(require, "mason-lspconfig")
if not status2 then
	return
end

-- Plugin: mason.nvim
--- https://github.com/williamboman/mason.nvim

mason.setup({})

lspconfig.setup({
	automatic_installation = true,
})

map("n", "<leader>ms", ":Mason<CR>")
