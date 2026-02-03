return {
  name = 'Jest: Run Test File',
  builder = function()
    local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
    -- Convert test file path to source file path
    -- e.g., app/components/foo/__tests__/Bar.spec.js -> app/components/foo/Bar.{ts,tsx}
    local source_file = file
      :gsub('/__tests__/', '/') -- Remove __tests__ directory
      :gsub('/__test__/', '/') -- Remove __test__ directory
      :gsub('%.spec%.[jt]sx?$', '') -- Remove .spec.js/.spec.ts/.spec.tsx
      :gsub('%.test%.[jt]sx?$', '') -- Remove .test.js/.test.ts/.test.tsx

    source_file = source_file .. '.{ts,tsx,js}'

    return {
      cmd = { 'yarn', 'test' },
      args = { file, '--coverage', '--collectCoverageFrom=' .. source_file },
      components = { { 'open_output', direction = 'vertical', on_complete = 'failure' }, 'default' },
      -- cmd = { 'sh', '-c', 'node --expose-gc $(yarn bin jest) --runInBand "$@"', '--', file },
      -- components = {
      --   { 'open_output', direction = 'vertical', on_complete = 'failure' },
      --   'default',
      -- },
    }
  end,
  condition = {
    filetype = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  },
}
