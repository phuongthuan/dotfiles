local autocmd = vim.api.nvim_create_autocmd
local nmap = require('core.utils').mapper_factory('n')

local M = {}

M.setup = function(event)
  local client = vim.lsp.get_client_by_id(event.data.client_id)

  if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
    local highlight_augroup = vim.api.nvim_create_augroup('nvim-lsp-highlight', { clear = false })

    autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('nvim-lsp-detach', { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({ group = 'nvim-lsp-highlight', buffer = event2.buf })
      end,
    })
  end

  if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
    nmap('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
    end, { desc = '[T]oggle Inlay [H]ints' })
  end
end

return M
