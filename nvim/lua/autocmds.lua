local autocmd = vim.api.nvim_create_autocmd
local nmap = require('core.utils').mapper_factory('n')

local function augroup(name)
  return vim.api.nvim_create_augroup('user' .. name, { clear = true })
end

autocmd('TextYankPost', {
  group = augroup('highlight_yanked_text'),
  pattern = '*',
  callback = function()
    vim.hl.on_yank()
  end,
})

autocmd('WinEnter', {
  group = augroup('highlight_cursorline_in_active_window'),
  pattern = '*',
  callback = function()
    vim.wo.cursorline = true
  end,
  desc = 'Highlight Cursorline On Active Window',
})

autocmd('TermOpen', {
  group = augroup('mapping_keymaps_for_terminal'),
  pattern = 'term://*',
  callback = function()
    if vim.bo.filetype == '' or vim.bo.filetype == 'toggleterm' then
      local opts = { silent = false, buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    end
  end,
})

autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'vim',
    'man',
    'help',
    'checkhealth',
    'lspinfo',
    'lsp.log',
    'query',
    'toggleterm',
    'mininotify-history',
    'spectre_panel',
    'OverseerOutput',
  },
  callback = function(e)
    -- Map q to exit in non-filetype buffers
    vim.bo[e.buf].buflisted = false
    nmap('q', function()
      -- Try to close window, fallback to buffer delete if it fails
      local ok = pcall(vim.cmd, 'close')
      if not ok then
        vim.cmd('bd')
      end
    end, { buffer = e.buf })
  end,
  desc = 'Maps q to exit on non-filetypes',
})

autocmd({ 'BufRead', 'BufNewFile' }, {
  group = augroup('set_filetype_for_env_files'),
  pattern = { '*.env', '.env.*' },
  callback = function()
    vim.opt_local.filetype = 'sh'
  end,
  desc = 'Auto set filetype for .env and .env.* files',
})

-- autocmd('BufWritePre', {
--   group = group,
--   pattern = '*',
--   command = [[%s/\s\+$//e]],
--   desc = 'Auto Remove Trailing Spaces On Save',
-- })

-- Enable spellcheck for certain files
-- autocmd('FileType', {
--   group = autocmds_group,
--   pattern = {
--     'gitcommit',
--     'markdown',
--     'txt',
--   },
--   callback = function()
--     vim.opt_local.spell = true
--     vim.opt_local.spelllang = 'en'
--   end,
--   desc = 'Enable spellcheck for certain files',
-- })
