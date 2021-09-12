local lspconfig = require('lspconfig')

local filetypes = {javascript = 'eslint', javascriptreact = 'eslint', typescript = 'eslint', typescriptreact = 'eslint'}

local linters = {
    eslint = {
        sourceName = 'eslint',
        command = 'eslint_d',
        rootPatterns = {'.eslintrc.js', 'package.json'},
        debounce = 100,
        args = {'--stdin', '--stdin-filename', '%filepath', '--format', 'json'},
        parseJson = {
            errorsRoot = '[0].messages',
            line = 'line',
            column = 'column',
            endLine = 'endLine',
            endColumn = 'endColumn',
            message = '${message} [${ruleId}]',
            security = 'severity'
        },
        securities = {[2] = 'error', [1] = 'warning'}
    }
}

local formatters = {prettier = {command = 'prettier', args = {'--stdin-filepath', '%filepath'}}}
local formatFiletypes = {javascript = 'prettier', javascriptreact = 'prettier', typescript = 'prettier', typescriptreact = 'prettier'}

local M = {}

M.setup = function(on_attach, capabilities)
    lspconfig.diagnosticls.setup {
        on_attach = on_attach,
        filetypes = vim.tbl_keys(filetypes),
        init_options = {linters = linters, filetypes = filetypes, formatters = formatters, formatFiletypes = formatFiletypes},
        capabilities = capabilities
    }
end

return M
