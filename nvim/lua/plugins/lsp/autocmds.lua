local M = {}

local autocmd = vim.api.nvim_create_autocmd
local nmap = require('core.utils').mapper_factory('n')

M.lsp_attach_augroup =
  vim.api.nvim_create_augroup('nvim-lsp-attach', { clear = true })

M.attach = function(event)
  -- The following two autocommands are used to highlight references of the
  -- word under your cursor when your cursor rests there for a little while.
  --    See `:help CursorHold` for information about when this is executed
  --
  -- When you move your cursor, the highlights will be cleared (the second autocommand).
  local client = vim.lsp.get_client_by_id(event.data.client_id)

  if
    client
    and client.supports_method(
      vim.lsp.protocol.Methods.textDocument_documentHighlight
    )
  then
    local highlight_augroup =
      vim.api.nvim_create_augroup('nvim-lsp-highlight', { clear = false })

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
        vim.api.nvim_clear_autocmds({
          group = 'nvim-lsp-highlight',
          buffer = event2.buf,
        })
      end,
    })
  end

  -- The following code creates a keymap to toggle inlay hints in your
  -- code, if the language server you are using supports them
  --
  -- This may be unwanted, since they displace some of your code
  if
    client
    and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint)
  then
    nmap('<leader>th', function()
      vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
      )
    end, { desc = '[T]oggle Inlay [H]ints' })
  end
end

return M
