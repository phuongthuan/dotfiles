return {
  name = 'Expo: Start with Debugger',
  builder = function()
    return {
      cmd = { 'yarn', 'start' },
      components = { { 'open_output', direction = 'dock', focus = true }, 'default' },
    }
  end,
  condition = {
    filetype = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  },
}
