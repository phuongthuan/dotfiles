local lspconfig = require('lspconfig')

local prettier = {formatCommand = 'prettier --stdin-filepath ${INPUT}', formatStdin = true}

local eslint = {
    lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {'%f(%l,%c): %tarning %m', '%f(%l,%c): %trror %m'}
}

local rubocop = {
    lintCommand = 'bundle exec rubocop --format emacs --force-exclusion --stdin ${INPUT}',
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {'%f:%l:%c: %t: %m'},
    formatCommand = 'bundle exec rubocop --auto-correct --force-exclusion --stdin ${INPUT} 2>/dev/null | sed "1,/^====================$/d"',
    formatStdin = true
}

local filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'ruby', 'json', 'lua'}

local M = {}

M.setup = function(on_attach, capabilities)
    lspconfig.efm.setup {
        init_options = {documentFormatting = true, codeAction = true},
        filetypes = filetypes,
        settings = {
            rootMarkers = {'package.json', '.git/', '.eslintrc.js'},
            languages = {
                javascript = {prettier, eslint},
                javascriptreact = {prettier, eslint},
                typescript = {prettier, eslint},
                typescriptreact = {prettier, eslint},
                ruby = {rubocop},
                json = {prettier},
                lua = {
                    {
                        formatCommand = 'lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb',
                        formatStdin = true
                    }
                }
            }
        },
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {debounce_text_changes = 150}
    }
end

return M
