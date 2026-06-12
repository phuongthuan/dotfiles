vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
})

local nmap = require('utils').nmap
local imap = require('utils').imap
local mapper = require('utils').mapper

require('mason').setup()
nmap('<leader>ms', '<cmd>Mason<cr>', { desc = 'Open Mason' })

-- Attach LSP to current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('nvim-lsp-attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local opts = { buffer = event.buf }

    if client then
      -- Keymaps
      local MiniPick = require('mini.extra').pickers

      nmap('<leader>cr', vim.lsp.buf.rename, { buffer = event.buf, desc = 'Code Rename' })
      nmap('gI', vim.lsp.buf.implementation, { buffer = event.buf, desc = 'Go To Implementation' })
      nmap('K', function()
        vim.lsp.buf.hover({ border = 'rounded', max_height = 25, max_width = 120 })
      end, opts)
      -- In your keybinding configuration
      -- { "K", function() vim.lsp.buf.hover { border = "single", max_height = 25, max_width = 120 } end, desc = "Hover documentation" }
      nmap('gd', vim.lsp.buf.definition, opts)
      nmap('gD', vim.lsp.buf.declaration, opts)
      mapper({ 'n', 'v' })('<leader>ca', vim.lsp.buf.code_action, { buffer = event.buf, desc = 'Code Actions' })
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
        nmap('<leader>cA', '<cmd>LspTypescriptSourceAction<cr>', { buffer = event.buf, desc = 'Code Actions (TS)' })
      end

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      if client:supports_method('textDocument/documentHighlight', event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('nvim-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('nvim-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({ group = 'nvim-lsp-highlight', buffer = event2.buf })
          end,
        })
      end

      -- The following code creates a keymap to toggle inlay hints the
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client:supports_method('textDocument/inlayHint', event.buf) then
        nmap('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, { buffer = event.buf, desc = 'Toggle Inlay Hints' })
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
  'basedpyright',
})
