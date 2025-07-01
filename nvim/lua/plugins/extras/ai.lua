return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false, auto_trigger = true },
        panel = { enabled = false },
        filetypes = {
          javascript = true,
          javascriptreact = true,
          typescript = true,
          typescriptreact = true,
          lua = true,
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
  },
  require('plugins.extras.codecompanion'),
  -- require('plugins.extras.copilotchat-nvim'),
}
