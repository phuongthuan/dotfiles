vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
  -- 'https://github.com/nvim-mini/mini.extra',
})

local nmap = require('utils').nmap
local imap = require('utils').imap
local mapper = require('utils').mapper

local function augroup(name, opts)
  return vim.api.nvim_create_augroup('user_' .. name, opts)
end

require('mason').setup()
nmap('<leader>ms', '<cmd>Mason<cr>', { desc = 'Open Mason' })

-- Attach LSP to current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup('nvim-lsp-attach', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local opts = { buffer = args.buf }

    if client then
      -- Keymaps
      local MiniPick = require('mini.extra').pickers

      nmap('<leader>cr', vim.lsp.buf.rename, { buffer = args.buf, desc = 'Code Rename' })
      nmap('gI', vim.lsp.buf.implementation, { buffer = args.buf, desc = 'Go To Implementation' })
      nmap('K', vim.lsp.buf.hover, opts)
      nmap('gd', vim.lsp.buf.definition, opts)
      nmap('gD', vim.lsp.buf.declaration, opts)
      mapper({ 'n', 'v' })('<leader>ca', vim.lsp.buf.code_action, { buffer = args.buf, desc = 'Code Actions' })
      imap('<C-h>', vim.lsp.buf.signature_help, opts)

      nmap('gr', function()
        MiniPick.lsp({ scope = 'references' })
      end, opts)

      nmap('gO', function()
        MiniPick.lsp({ scope = 'document_symbol' })
      end, opts)

      nmap('<leader>cd', function()
        MiniPick.diagnostic({ scope = 'current' }, { source = { name = '  Diagnostics (current)' } })
      end, { desc = 'Diagnostics (current buffer)' })

      nmap('<leader>cD', function()
        MiniPick.diagnostic(nil, { source = { name = '  Diagnostics (all)' } })
      end, { desc = 'Diagnostics (all)' })

      if client.name == 'ts_ls' then
        nmap('<leader>cA', '<cmd>LspTypescriptSourceAction<cr>', { buffer = args.buf, desc = 'Code Actions (TS)' })
      end

      -- Inlay hints
      if client:supports_method('textDocument/inlayHints') then
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      end
    end
  end,
})

vim.lsp.enable({
  'lua_ls',
  'ts_ls',
  'ruby_lsp',
  'bashls',
  'yamlls',
})
