return {
  name = 'Jest: Run Test File',
  builder = function()
    local file = vim.fn.expand('%:p')
    return {
      -- "test": "node --expose-gc $(yarn bin jest) --runInBand --watch" (package.json script)
      cmd = { 'sh', '-c', 'node --expose-gc $(yarn bin jest) --runInBand "$@"', '--', file },
      components = {
        { 'open_output', direction = 'vertical', on_complete = 'failure' },
        'default',
      },
    }
  end,
  condition = {
    filetype = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  },
}
