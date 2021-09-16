-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------

local sumneko = require('lsp/sumneko')
local tsserver = require('lsp/tsserver')
local efm = require('lsp/efm')

-- plugin: nvim-lspconfig
--- For language server setup see: https://github.com/neovim/nvim-lspconfig

-- custom diagnosticls look and feel
vim.lsp.handlers['textDocument/publishDiagnostics'] = function(...)
  vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = false,
      underline = true,
      update_in_insert = false,
    }
  )(...)
  pcall(vim.lsp.diagnostic.set_loclist, {open_loclist = false})
end

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = {noremap = true, silent = true}

    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    if client.name == 'tsserver' then client.resolved_capabilities.document_formatting = false end

    -- Format onsave
    -- if client.resolved_capabilities.document_formatting then
    --     vim.api.nvim_command [[augroup Format]]
    --     vim.api.nvim_command [[autocmd! * <buffer>]]
    --     vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync(nil, 1000)]]
    --     vim.api.nvim_command [[augroup END]]
    -- end
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Lua language server
sumneko.setup(on_attach, capabilities)

-- npm install -g typescript typescript-language-server
tsserver.setup(on_attach, capabilities)

-- brew install efm-langserver
-- npm install -g eslint_d
efm.setup(on_attach, capabilities)
