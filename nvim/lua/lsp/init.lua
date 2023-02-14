local tsserver = require('lsp/tsserver')
local solargraph = require('lsp/solargraph')

local map = vim.keymap.set

--- For language server setup see: https://github.com/neovim/nvim-lspconfig
-- plugin: nvim-lspconfig

-- custom diagnosticls look and feel
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.lsp.diagnostic.on_publish_diagnostics, {
   -- Enable underline, use default values
   underline = true,
   virtual_text = false,
   update_in_insert = false,
 }
)

local on_attach = function(client, bufnr)

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }

    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', bufopts)
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', bufopts)
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', bufopts)
    map('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', bufopts)
    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', bufopts)

    map('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', bufopts)
    map('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', bufopts)
    map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', bufopts)

    map('n', '<leader>cf', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', bufopts)
    map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', bufopts)
    map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', bufopts)

    if client.name == 'solargraph' or client.name == 'tsserver' then
      client.server_capabilities.documentFormattingProvider = false
    end
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- language-server configuration
-- Check for specific server configuration
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- npm install -g typescript typescript-language-server
tsserver.setup(on_attach, capabilities)

-- gem install solargraph
solargraph.setup(on_attach, capabilities)

-- brew install efm-langserver
-- npm install -g eslint_d
-- efm.setup(on_attach, capabilities)

require('lsp.html')

-- npm install -g @tailwindcss/language-server
-- require 'lsp.tailwindcss'

require 'lsp.null-ls'
