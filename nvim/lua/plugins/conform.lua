-- Autoformat
-- Recipes https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md
local slow_format_filetypes = {}
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[C]ode [F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable autoformat on certain filetypes
      -- local ignore_filetypes = { 'sql', 'java' }
      -- if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
      --   return
      -- end

      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      -- Disable autoformat for files in a certain path
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match '/node_modules/' then
        return
      end

      -- Automatically run slow formatters async
      if slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end

      local function on_format(err)
        if err and err:match 'timeout$' then
          slow_format_filetypes[vim.bo[bufnr].filetype] = true
        end
      end

      return {
        timeout_ms = 2000,
        lsp_format = 'fallback',
        on_format,
      }
    end,
    format_after_save = function(bufnr)
      if not slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end
      return { lsp_format = 'fallback' }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      zsh = { 'shfmt' },
      ruby = { 'rubocop' },
      javascript = { { 'prettierd', 'prettier' } },
      typescript = { { 'prettierd', 'prettier' } },
      typescriptreact = { { 'prettierd', 'prettier' } },
      javascriptreact = { { 'prettierd', 'prettier' } },
      json = { { 'prettierd', 'prettier' } },
      jsonc = { { 'prettierd', 'prettier' } },
      markdown = { { 'prettierd', 'prettier' } },
      css = { { 'prettierd', 'prettier' } },
      scss = { { 'prettierd', 'prettier' } },
      html = { { 'prettierd', 'prettier' } },
    },
    formatters = {
      prettier = {
        prepend_args = { '--prose-wrap', 'always' },
      },
      shfmt = {
        prepend_args = { '-i', '2' },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}

-- vim: ts=2 sts=2 sw=2 et
