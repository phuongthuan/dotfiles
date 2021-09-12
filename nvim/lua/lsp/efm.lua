local lspconfig = require('lspconfig')

local M = {}

M.setup = function(on_attach, capabilities)
    -- Configure formatting for Lua
    lspconfig.efm.setup {
        on_attach = on_attach,
        init_options = {documentFormatting = true},
        filetypes = {'lua'},
        settings = {
            rootMarkers = {'.git/'},
            languages = {
                lua = {
                    {
                        formatCommand = 'lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb',
                        formatStdin = true
                    }
                }
            }
        },
        capabilities = capabilities
    }
end

return M
