local null_ls = require("null-ls")

-- null-ls.nvim
-- https://github.com/jose-elias-alvarez/null-ls.nvim

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	sources = {
		formatting.rubocop,
		formatting.prettier,
		formatting.stylua,
		diagnostics.rubocop,
    diagnostics.luacheck
	},

	diagnostics_format = "[#{c}] #{m} (#{s})",
})
