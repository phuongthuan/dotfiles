-- tsserver is typescript language server
-- npm install --location=global typescript typescript-language-server

local lspconfig = require("lspconfig")

local M = {}

M.setup = function(on_attach, capabilities)
	lspconfig.tsserver.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		flags = { debounce_text_changes = 150 },
	})
end

return M
