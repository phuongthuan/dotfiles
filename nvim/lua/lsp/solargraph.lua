-- Solargraph is Ruby language server
-- gem install solargraph

local lspconfig = require("lspconfig")

local M = {}

M.setup = function(on_attach, capabilities)
	lspconfig.solargraph.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		flags = { debounce_text_changes = 150 },
	})
end

return M
