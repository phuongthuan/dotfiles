local M = {}

M.IsCodeCompanion = function()
  return package.loaded.codecompanion and vim.bo.filetype == 'codecompanion'
end

M.IsGitHubActionWorkflow = function()
  local filepath = vim.api.nvim_buf_get_name(0)
  local is_yml_yaml = filepath:match('%.ya?ml$')
  local in_workflows_dir = filepath:find('/.github/workflows/', 1, true) ~= nil

  -- render if current file is yml/yaml and in .github/workflows/ directory
  return is_yml_yaml and in_workflows_dir
end

M.GetFileIcons = function()
  local filename = vim.api.nvim_buf_get_name(0)
  local extension = vim.fn.fnamemodify(filename, ':e')
  return require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
end

return M
