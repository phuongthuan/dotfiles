local api = vim.api
local autocmd = api.nvim_create_autocmd --[[@type function]]

---Helper to create augroups
---@param name string
local function augroup(name)
  return api.nvim_create_augroup('user' .. name, { clear = true })
end

autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
      vim.cmd('TSUpdate')
    end
  end,
})

autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'checkhealth',
    'help',
    'lspinfo',
    'gitsigns-blame',
    'netrw',
    'qf',
    'spectre_panel',
    'toggleterm',
    -- 'mininotify-history',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd('close')
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Close and delete buffer',
      })
    end)
  end,
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

autocmd('BufWritePre', {
  group = augroup('remove_trailing_whitespace'),
  pattern = '*',
  callback = function()
    vim.cmd([[%s/\s\+$//e]])
  end,
})

autocmd('TextYankPost', {
  group = augroup('highlight_yanked_text'),
  pattern = '*',
  callback = function()
    vim.hl.on_yank()
  end,
})
