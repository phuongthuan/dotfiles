return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      -- bash = { 'shellcheck' },
      -- sh = { 'shellcheck' },
      -- zsh = { 'zsh' },
      typescript = { 'eslint_d', 'eslint' },
      javascript = { 'eslint_d', 'eslint' },
      typescriptreact = { 'eslint_d', 'eslint' },
      javascriptreact = { 'eslint_d', 'eslint' },
      -- markdown = { 'markdownlint' },
      -- json = { 'jsonlint' },
      -- text = { 'vale' },
    }

    lint.linters.eslint_d.args = {
      '--no-warn-ignored',
      '--format',
      'json',
      '--stdin',
      '--stdin-filename',
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
    }

    lint.linters_by_ft['markdown'] = nil

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
