return {
  name = '(Overseer) Mobile: yarn type-check',
  builder = function()
    return {
      cmd = { 'yarn', 'workspace', 'EHLife', 'type-check' },
      components = { { 'open_output', direction = 'dock', focus = true }, 'default' },
    }
  end,
  condition = {
    filetype = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  },
}
