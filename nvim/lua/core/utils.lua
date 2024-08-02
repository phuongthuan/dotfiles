local M = {}

--- Creates a keymap function with given mode
---@param mode string|table
---@return fun(lhs: string, rhs: string|function, opts: table|nil)
function M.mapper_factory(mode)
  local default_opts = { silent = true }

  return function(lhs, rhs, opts)
    local final_opts = vim.tbl_extend('force', default_opts, opts or {})
    vim.keymap.set(mode, lhs, rhs, final_opts)
  end
end

return M
