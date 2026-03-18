vim.pack.add({
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/stevearc/overseer.nvim',
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/phuongthuan/nvim-tmux-navigation',
  { src = 'https://github.com/mg979/vim-visual-multi', version = 'master' },
  'https://github.com/nvim-pack/nvim-spectre',
  'https://github.com/uga-rosa/translate.nvim',
  'https://github.com/akinsho/toggleterm.nvim',
  'https://github.com/mistweaverco/kulala.nvim',
})

local nmap = require('utils').nmap
local mapper = require('utils').mapper

-- nvim-surround
require('nvim-surround').setup()

-- overseer.nvim
require('overseer').setup({
  templates = {
    'builtin',
    'vscode',
  },
})

nmap('<leader>oo', '<cmd>OverseerToggle!<cr>', { desc = 'Overseer: Open' })
nmap('<leader>or', '<cmd>OverseerRun<cr>', { desc = 'Overseer: Run' })
nmap('<leader>ot', '<cmd>OverseerTaskAction<cr>', { desc = 'Overseer: Task Action' })

-- oil.nvim
require('oil').setup({
  default_file_explorer = true,
  view_options = { show_hidden = true },
  win_options = { wrap = true },
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  keymaps = {
    ['<C-v>'] = {
      'actions.select',
      opts = { vertical = true },
    },
    ['<C-s>'] = {
      'actions.select',
      opts = { horizontal = true },
    },
    ['gd'] = {
      desc = 'Oil: Toggle File Detail View',
      callback = function()
        local oil = require('oil')
        local config = require('oil.config')
        if #config.columns == 1 then
          oil.set_columns({ 'icon', 'permissions', 'size', 'mtime' })
        else
          oil.set_columns({ 'icon' })
        end
      end,
    },
    ['<C-r>'] = 'actions.refresh',
    ['<C-y>'] = 'actions.copy_entry_path',
    ['>'] = 'actions.toggle_hidden',

    ['<C-c>'] = false,
    ['<C-p>'] = false,
    ['<C-t>'] = false,
    ['<C-b>'] = false,
    ['<C-h>'] = false,
    ['<C-l>'] = false,
    ['gs'] = false,
  },
})

-- vim-visual-multi
require('nvim-tmux-navigation').setup({
  disable_when_zoomed = true, -- defaults to false
  keybindings = {
    left = '<C-h>',
    down = '<C-j>',
    up = '<C-k>',
    right = '<C-l>',
    -- last_active = '<C-\\>',
    -- next = '<C-Space>',
  },
})

local function tmux_command(command)
  local tmux_socket = vim.fn.split(vim.env.TMUX, ',')[1]
  return vim.fn.system('tmux -S ' .. tmux_socket .. ' ' .. command)
end

local nvim_tmux_nav_group = vim.api.nvim_create_augroup('NvimTmuxNavigation', {})
local autocmd = vim.api.nvim_create_autocmd

autocmd({ 'VimEnter', 'VimResume' }, {
  group = nvim_tmux_nav_group,
  callback = function()
    tmux_command('set-option -p @is_vim yes')
  end,
})

autocmd({ 'VimLeave', 'VimSuspend' }, {
  group = nvim_tmux_nav_group,
  callback = function()
    tmux_command('set-option -p -u @is_vim')
  end,
})

-- nvim-spectre
require('spectre').setup({
  replace_engine = {
    ['sed'] = {
      cmd = 'sed',
      args = { '-i', '', '-E' },
    },
  },
  mapping = {
    ['send_to_qf'] = {
      map = '<leader>qf',
      cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
      desc = 'send all items to quickfix',
    },
  },
})

nmap('<leader>sr', '<cmd>lua require("spectre").toggle()<cr>', { desc = 'Toggle Spectre' })
nmap('<leader>sp', '<cmd>lua require("spectre").open_file_search({ select_word = true })<CR>', {
  desc = 'Search current word on current buffer',
})

-- translate.nvim
require('translate').setup({})
mapper({ 'n', 'v' })('<leader>tT', '<cmd>Translate Vi<cr>', { desc = 'Translate Text' })

-- toggleterm.nvim
require('toggleterm').setup({})
nmap('<leader>tt', '<cmd>ToggleTerm<cr>', { desc = 'Toggle Terminal' })

-- kulala.nvim
require('kulala').setup({
  global_keymaps = true,
  global_keymaps_prefix = '<leader>R',
  kulala_keymaps_prefix = '',
})

nmap('<leader>Rs', '<cmd>lua require("kulala").run()<cr>', { desc = 'Send request' })
nmap('<leader>Ra', '<cmd>lua require("kulala").run_all()<cr>', { desc = 'Send all requests' })
nmap('<leader>Rb', '<cmd>lua require("kulala").scratchpad()<cr>', { desc = 'Open scratchpad' })
