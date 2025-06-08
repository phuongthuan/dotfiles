local mapper = require('core.utils').mapper_factory
local nmap = mapper('n')

local M = {}

M.setup = function(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  if not client then
    return
  end

  local mini_pickers = require('mini.extra').pickers

  local bufnr = args.buf
  local opts = { buffer = bufnr }

  nmap('<leader>cr', vim.lsp.buf.rename, opts)
  nmap('gI', vim.lsp.buf.implementation, opts)
  nmap('K', vim.lsp.buf.hover, opts)
  nmap('gD', vim.lsp.buf.declaration, opts)

  mapper({ 'n', 'v' })('<leader>ca', vim.lsp.buf.code_action, opts)

  nmap('gd', function()
    mini_pickers.lsp({ scope = 'definition' })
  end, opts)

  -- nmap('gr', vim.lsp.buf.references, opts)
  nmap('gr', function()
    mini_pickers.lsp({ scope = 'references' })
  end, opts)

  vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)

  if client.name == 'ts_ls' then
    nmap('<leader>sa', '<cmd>LspTypescriptSourceAction<cr>', opts)
  end
end

return M
