local mapper = require('core.utils').mapper_factory
local nmap = mapper('n')
local imap = mapper('i')

local M = {}

M.setup = function(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  local opts = { buffer = args.buf }

  if not client then
    return
  end

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
end

return M
