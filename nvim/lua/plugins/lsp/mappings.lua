local mapper = require('core.utils').mapper_factory
local nmap = mapper('n')

local M = {}

M.attach = function(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  if not client then
    return
  end

  local mini = require('mini.extra').pickers
  local bufnr = args.buf
  -- local lsp_utils = require('plugins.lsp.utils')

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  -- nmap('gd', vim.lsp.buf.definition, { buffer = bufnr })
  nmap('gd', function()
    mini.lsp({ scope = 'definition' })
  end, { buffer = bufnr })

  -- Find references for the word under your cursor.
  -- nmap('gr', vim.lsp.buf.references, { buffer = bufnr })
  nmap('gr', function()
    mini.lsp({ scope = 'references' })
  end, { buffer = bufnr })

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  nmap('gI', vim.lsp.buf.implementation, { buffer = bufnr })

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  -- nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, { buffer = bufnr })

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, { buffer = bufnr })

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  -- nmap(
  --   '<leader>ws',
  --   require('telescope.builtin').lsp_dynamic_workspace_symbols,
  --   { buffer = bufnr }
  -- )

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, { buffer = bufnr })

  nmap('<leader>cr', vim.lsp.buf.rename, { buffer = bufnr })

  mapper({ 'n', 'v' })('<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })

  nmap('K', vim.lsp.buf.hover, { buffer = bufnr })

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  -- For example, in C this would take you to the header.
  nmap('gD', vim.lsp.buf.declaration, { buffer = bufnr })

  -- if client.name == 'typescript-tools' or client.name == 'vtsls' then
  --   local ts_mappings = lsp_utils.generate_ts_mappings(client.name)
  --
  --   nmap('<leader>oi', ts_mappings.organize_imports, { buffer = bufnr })
  --   nmap('<leader>rf', ts_mappings.rename_file, { buffer = bufnr })
  --   nmap('<leader>gd', ts_mappings.go_to_source_definition, { buffer = bufnr })
  --   nmap('<leader>mi', ts_mappings.add_missing_imports, { buffer = bufnr })
  --   nmap('<leader>ru', ts_mappings.remove_unused_imports, { buffer = bufnr })
  -- end
end

return M
