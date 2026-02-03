return {
  name = 'Maestro: Run Test File',
  builder = function()
    local file = vim.fn.expand('%:p')
    return {
      cmd = { 'maestro', 'test', '--debug-output=maestro_output' },
      args = { file },
      components = { { 'open_output', direction = 'vertical', focus = true }, 'default' },
    }
  end,
  condition = {
    filetype = { 'yml', 'yaml' },
  },
}
