-- Autoformat
return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[C]ode [F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        javascript = { { 'prettier_d', 'prettier' } },
        typescript = { { 'prettier_d', 'prettier' } },
        typescriptreact = { { 'prettier_d', 'prettier' } },
        javascriptreact = { { 'prettier_d', 'prettier' } },
        json = { { 'prettier_d', 'prettier' } },
        jsonc = { { 'prettier_d', 'prettier' } },
        markdown = { { 'prettier_d', 'prettier' } },
        css = { { 'prettier_d', 'prettier' } },
        scss = { { 'prettier_d', 'prettier' } },
        html = { { 'prettier_d', 'prettier' } },
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
  },
}

-- vim: ts=2 sts=2 sw=2 et
