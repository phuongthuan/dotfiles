-- Sumneko is lua-language-server

-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
USER = vim.fn.expand('$USER')

local lspconfig = require('lspconfig')

-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)

local sumneko_root_path = ''
local sumneko_binary = ''

if vim.fn.has('mac') == 1 then
    sumneko_root_path = '/Users/' .. USER .. '/.config/lua-language-server'
    sumneko_binary = '/Users/' .. USER .. '/.config/lua-language-server/bin/macOS/lua-language-server'
elseif vim.fn.has('unix') == 1 then
    sumneko_root_path = '/home/' .. USER .. '/.config/lua-language-server'
    sumneko_binary = '/home/' .. USER .. '/.config/lua-language-server/bin/Linux/lua-language-server'
else
    print('Unsupported system for sumneko')

end

local settings = {
    Lua = {
        runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = vim.split(package.path, ';')
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'}
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
        }
    }
}

local M = {}

M.setup = function(on_attach, capabilities)
    lspconfig.sumneko_lua.setup {
        on_attach = on_attach,
        cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'},
        settings = settings,
        flags = {debounce_text_changes = 150},
        capabilities = capabilities
    }
end

return M
