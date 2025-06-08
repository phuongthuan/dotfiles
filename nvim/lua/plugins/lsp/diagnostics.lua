local icons = require('core.icons').diagnostics
local nmap = require('core.utils').mapper_factory('n')

local M = {}

function M.setup()
  vim.diagnostic.config({
    severity_sort = true,
    float = { border = 'rounded', source = true },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.error,
        [vim.diagnostic.severity.WARN] = icons.warn,
        [vim.diagnostic.severity.HINT] = icons.hint,
        [vim.diagnostic.severity.INFO] = icons.info,
      },
    } or {},
    virtual_text = {
      source = true,
      spacing = 2,
      format = function(diagnostic)
        local diagnostic_message = {
          [vim.diagnostic.severity.ERROR] = diagnostic.message,
          [vim.diagnostic.severity.WARN] = diagnostic.message,
          [vim.diagnostic.severity.INFO] = diagnostic.message,
          [vim.diagnostic.severity.HINT] = diagnostic.message,
        }
        return diagnostic_message[diagnostic.severity]
      end,
    },
  })

  -- Keymaps
  -- nmap(']d', vim.diagnostic.goto_next, { desc = 'Go To Next Diagnostic' })
  -- nmap('[d', vim.diagnostic.goto_prev, { desc = 'Go To Previous Diagnostic' })
  nmap('<leader>e', vim.diagnostic.open_float, { desc = 'Show Line Diagnostic' })
end

return M
