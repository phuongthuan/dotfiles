return {
  name = 'Jest: Run Test File',
  builder = function()
    local file = vim.fn.expand('%:p')
    return {
      cmd = { 'yarn', 'test' },
      args = { file },
      components = { { 'open_output', direction = 'dock', focus = true }, 'default' },
    }
  end,
  condition = {
    filetype = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  },
}
