local lspconfig = require('lspconfig')

local M = {}

M.setup = function(on_attach, capabilities)
    lspconfig.tsserver.setup {
        on_attach = function(client)
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false
            on_attach(client)
        end,
        capabilities = capabilities,
        flags = {debounce_text_changes = 150}
    }
end

return M
