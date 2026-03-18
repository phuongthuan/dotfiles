vim.pack.add({
  'https://github.com/stevearc/conform.nvim',
})

local nmap = require('utils').nmap
local mapper = require('utils').mapper

-- Recipes https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md
local slow_format_filetypes = {}
local ignore_filetypes = { 'sql', 'java' }

local prettierd = { 'prettierd', stop_after_first = true }

-- Disable auto format by default
-- vim.g.disable_autoformat = true

-- If you want the formatexpr, here is the place to set it
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Command to run async formatting
vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format({ async = true, lsp_format = 'fallback', range = range })
end, { range = true })

vim.api.nvim_create_user_command('FormatDisable', function(opts)
  if opts.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})

require('conform').setup({
  log_level = vim.log.levels.DEBUG,
  -- notify_on_error = false,
  format_on_save = function(bufnr)
    -- Disable autoformat on certain filetypes
    if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
      return
    end

    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    -- Disable autoformat for files in a certain path
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if
      bufname:match('/node_modules/')
      or bufname:match('/ios/')
      or bufname:match('/android/')
      or bufname:match('~/.local/share/nvim/')
    then
      return
    end

    -- Automatically run slow formatters async
    if slow_format_filetypes[vim.bo[bufnr].filetype] then
      return
    end

    local function on_format(err)
      if err and err:match('timeout$') then
        slow_format_filetypes[vim.bo[bufnr].filetype] = true
      end
    end

    return {
      timeout_ms = 500,
      lsp_format = 'fallback',
      on_format,
    }
  end,
  format_after_save = function(bufnr)
    if not slow_format_filetypes[vim.bo[bufnr].filetype] then
      return
    end
    return { lsp_format = 'fallback' }
  end,
  formatters_by_ft = {
    lua = { 'stylua' },
    zsh = { 'shfmt' },
    ruby = { 'rubocop' },
    http = { 'kulala' },
    javascript = prettierd,
    typescript = prettierd,
    typescriptreact = prettierd,
    javascriptreact = prettierd,
    json = prettierd,
    jsonc = prettierd,
    markdown = prettierd,
    css = prettierd,
    scss = prettierd,
    html = prettierd,
    yaml = prettierd,
  },
  formatters = {
    shfmt = {
      prepend_args = { '-i', '2' },
    },
    kulala = {
      command = 'kulala-fmt',
      args = { 'format', '--stdin' },
    },
  },
})

nmap('<leader>cf', function()
  require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Code Format' })

nmap('<leader>cn', '<cmd>ConformInfo<cr>', { desc = 'Conform Info' })

nmap('<leader>tf', function()
  if vim.g.disable_autoformat then
    vim.cmd('FormatEnable')
    vim.notify('Format On Save Enabled ✔', vim.log.levels.INFO)
  else
    vim.cmd('FormatDisable')
    vim.notify('Format On Save Disabled ✔', vim.log.levels.INFO)
  end
end, { desc = 'Toggle Format On Save' })
