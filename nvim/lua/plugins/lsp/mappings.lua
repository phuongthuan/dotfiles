local mapper = require('core.utils').mapper_factory
local nmap = mapper('n')
local imap = mapper('i')

local M = {}

M.setup = function(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  if not client then
    return
  end

  local mini_pickers = require('mini.extra').pickers

  -- Wrapper default vim ui with snipe
  local snipe = require('snipe')
  snipe.ui_select_menu = require('snipe.menu'):new({ position = 'cursor' })
  snipe.ui_select_menu:add_new_buffer_callback(function(m)
    nmap('<esc>', function()
      m:close()
    end, { nowait = true, buffer = m.buf })
    nmap('q', function()
      m:close()
    end, { nowait = true, buffer = m.buf })
  end)
  vim.ui.select = snipe.ui_select

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

  nmap('gr', function()
    mini_pickers.lsp({ scope = 'references' })
  end, opts)

  nmap('gO', function()
    mini_pickers.lsp({ scope = 'document_symbol' })
  end, opts)

  imap('<C-h>', vim.lsp.buf.signature_help, opts)

  if client.name == 'ts_ls' then
    nmap('<leader>sa', '<cmd>LspTypescriptSourceAction<cr>', opts)
  end
end

return M
