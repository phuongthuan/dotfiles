return {
  name = '(Overseer) Mobile: Run Test',
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

    -- Paths must be relative to jest rootDir (apps/eh-app/), not repo root
    local coverage_path = source_file:gsub('^apps/eh%-app/', '')

    return {
      cmd = { 'yarn', 'workspace', 'EHLife', 'test' },
      args = { file, '--watch=false', '--forceExit', '--coverage', '--collectCoverageFrom=' .. coverage_path },
      -- see :help overseer-components for a list of all components.
      -- components = { { 'open_output', direction = 'vertical', on_complete = 'failure' }, 'default' },
      components = {
        { 'on_output_quickfix', set_diagnostics = true },
        'on_result_diagnostics',
        'default',
      },
    }
  end,
  condition = {
    filetype = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  },
}
