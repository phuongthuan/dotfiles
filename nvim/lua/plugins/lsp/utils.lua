local M = {}

--- Takes a client name and generates utility mappings for that client
M.generate_ts_mappings = function(client_name)
  -- typescript-tools.nvim utils
  local organize_imports = client_name == 'typescript-tools'
      and '<Cmd>TSToolsOrganizeImports<CR>'
    or '<Cmd>VtsExec organize_imports<CR>'

  -- allow to rename current file and apply changes to connected files
  local rename_file = client_name == 'typescript-tools'
      and '<Cmd>TSToolsRenameFile<CR>'
    or '<Cmd>VtsExec rename_file<CR>'

  -- adds imports for all statements that lack one and can be imported
  local add_missing_imports = client_name == 'typescript-tools'
      and '<Cmd>TSToolsAddMissingImports<CR>'
    or '<Cmd>VtsExec add_missing_imports<CR>'

  -- goes to source definition (available since TS v4.7)
  local go_to_source_definition = client_name == 'typescript-tools'
      and '<Cmd>TSToolsGoToSourceDefinition<CR>'
    or '<Cmd>VtsExec go_to_source_definition<CR>'

  -- removes unused imports
  local remove_unused_imports = client_name == 'typescript-tools'
      and '<Cmd>TSToolsRemoveUnusedImports<CR>'
    or '<Cmd>VtsExec remove_unused_imports<CR>'

  return {
    organize_imports = organize_imports,
    rename_file = rename_file,
    add_missing_imports = add_missing_imports,
    go_to_source_definition = go_to_source_definition,
    remove_unused_imports = remove_unused_imports,
  }
end

return M
