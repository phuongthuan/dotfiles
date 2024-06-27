local map = vim.keymap.set

local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

-- null-ls.nvim
-- https://github.com/jose-elias-alvarez/null-ls.nvim

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = true,
	sources = {
		formatting.prettier,
		formatting.stylua,
		formatting.rubocop,

		diagnostics.rubocop,
		require("none-ls.diagnostics.eslint_d"),
	},

	diagnostics_format = "#{m} [#{c}]",
})

map("n", "<leader>ls", ":NullLsInfo<CR>")
