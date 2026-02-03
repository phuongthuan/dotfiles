function t.ToggleLineNumbers()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
  else
    vim.wo.relativenumber = true
  end
end

function t.IsGitHubActionWorkflow()
  local filepath = vim.api.nvim_buf_get_name(0)
  local is_yml_yaml = filepath:match('%.ya?ml$')
  local in_workflows_dir = filepath:find('/.github/workflows/', 1, true) ~= nil

  -- render if current file is yml/yaml and in .github/workflows/ directory
  return is_yml_yaml and in_workflows_dir
end

function t.IsCodeCompanion()
  -- return package.loaded.codecompanion and vim.bo.filetype == 'codecompanion'
  return vim.bo.filetype == 'codecompanion'
end
