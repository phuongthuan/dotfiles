local M = {}

local autocmd = vim.api.nvim_create_autocmd
M.lsp_augroup_id = vim.api.nvim_create_augroup('UserLspGroup', { clear = true })

M.attach = function(args)
  -- The following two autocommands are used to highlight references of the
  -- word under your cursor when your cursor rests there for a little while.
  --    See `:help CursorHold` for information about when this is executed
  --
  -- When you move your cursor, the highlights will be cleared (the second autocommand).
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if client and client.server_capabilities.documentHighlightProvider then
    autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = M.lsp_augroup_id,
      buffer = args.buf,
      callback = vim.lsp.buf.document_highlight,
      desc = 'Highlights symbol under cursor',
    })

    autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      group = M.lsp_augroup_id,
      buffer = args.buf,
      callback = vim.lsp.buf.clear_references,
      desc = 'Clears symbol highlighting under cursor',
    })
  end
end

return M
