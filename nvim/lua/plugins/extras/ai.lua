return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        copilot_node_command = vim.fn.expand('$HOME') .. '/.asdf/installs/nodejs/22.20.0/bin/node',
        suggestion = { enabled = false, auto_trigger = true },
        panel = { enabled = false },
        filetypes = {
          javascript = true,
          javascriptreact = true,
          typescript = true,
          typescriptreact = true,
          lua = true,
          json = true,
          sh = function()
            if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
              -- disable for .env files
              return false
            end
            return true
          end,
          -- Disable all other file types
          ['*'] = false,
        },
      })
    end,
    keys = {
      {
        '<C-a>',
        function()
          require('copilot.suggestion').accept()
        end,
        desc = 'Copilot: Accept suggestion',
        mode = { 'i' },
      },
      {
        '<C-x>',
        function()
          require('copilot.suggestion').dismiss()
        end,
        desc = 'Copilot: Dismiss suggestion',
        mode = { 'i' },
      },
      {
        '<C-\\>',
        function()
          require('copilot.panel').open()
        end,
        desc = 'Copilot: Show panel',
        mode = { 'n', 'i' },
      },
    },
  },
  require('plugins.extras.codecompanion'),
}
