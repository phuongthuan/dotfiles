local command = vim.api.nvim_create_user_command --[[@type function]]

command('ToggleLineNumbers', function()
  t.ToggleLineNumbers()
end, { desc = 'Toggle Line Numbers' })
