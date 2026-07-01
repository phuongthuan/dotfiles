local autocmd = vim.api.nvim_create_autocmd --[[@type function]]
local nmap = require('utils').nmap

---Helper to create augroups
---@param name string
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

local close_with_q_group = augroup('close_with_q')

local function map_q_to_close(e)
  vim.bo[e.buf].buflisted = false
  nmap('q', function()
    local ok = pcall(vim.cmd, 'close')
    if not ok then
      vim.cmd('bd')
    end
  end, { buffer = e.buf })
end

autocmd('FileType', {
  group = close_with_q_group,
  pattern = {
    'vim',
    'man',
    'help',
    'checkhealth',
    'lspinfo',
    'qf',
    'oil',
    'gitsigns-blame',
    'git',
    'query',
    'toggleterm',
    'mininotify-history',
    'spectre_panel',
    'OverseerOutput',
    'nvim-pack',
  },
  callback = map_q_to_close,
  desc = 'Maps q to exit on non-filetypes',
})

autocmd('BufWinEnter', {
  group = close_with_q_group,
  pattern = vim.lsp.log.get_filename(),
  callback = map_q_to_close,
  desc = 'Maps q to exit on lsp.log',
})

autocmd('BufWinEnter', {
  group = close_with_q_group,
  pattern = { '*.png', '*.jpg', '*.jpeg' },
  callback = map_q_to_close,
  desc = 'Maps q to close image buffers',
})

autocmd('BufWritePre', {
  group = augroup('remove_trailing_whitespace'),
  pattern = '*',
  callback = function()
    vim.cmd([[%s/\s\+$//e]])
  end,
})

autocmd({ 'BufRead', 'BufNewFile' }, {
  group = augroup('set_filetype_for_env_files'),
  pattern = { '*.env', '.env.*' },
  callback = function()
    vim.opt_local.filetype = 'sh'
  end,
  desc = 'Auto set filetype for .env and .env.* files',
})
