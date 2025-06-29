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

  nmap('<leader>cr', vim.lsp.buf.rename, opts)
  nmap('gI', vim.lsp.buf.implementation, opts)
  nmap('K', vim.lsp.buf.hover, opts)
  nmap('gd', vim.lsp.buf.definition, opts)
  nmap('gD', vim.lsp.buf.declaration, opts)
  mapper({ 'n', 'v' })('<leader>ca', vim.lsp.buf.code_action, opts)
  imap('<C-h>', vim.lsp.buf.signature_help, opts)

  nmap('gr', function()
    MiniPick.lsp({ scope = 'references' })
  end, opts)

  nmap('gO', function()
    MiniPick.lsp({ scope = 'document_symbol' })
  end, opts)

  nmap('<leader>d', function()
    MiniPick.diagnostic({ scope = 'current' }, { source = { name = '  Diagnostics (current)' } })
  end, { desc = 'List all diagnostics in current buffer' })

  nmap('<leader>D', function()
    MiniPick.diagnostic(nil, { source = { name = '  Diagnostics (all)' } })
  end, { desc = 'List all diagnostics in loaded buffers' })

  if client.name == 'ts_ls' then
    nmap('<leader>sa', '<cmd>LspTypescriptSourceAction<cr>', opts)
  end
end

return M
