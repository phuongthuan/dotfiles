local nmap = require('core.utils').mapper_factory('n')

return {
  { 'mg979/vim-visual-multi', branch = 'master' },
  {
    'kylechui/nvim-surround',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },
  {
    'nvim-pack/nvim-spectre',
    opts = {
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
    },
    keys = {
      {
        '<leader>sr',
        '<cmd>lua require("spectre").toggle()<cr>',
        desc = 'Toggle Spectre',
        silent = true,
      },
      {
        '<leader>sp',
        '<cmd>lua require("spectre").open_file_search({ select_word = true })<CR>',
        desc = 'Search current word on current buffer',
        silent = true,
      },
    },
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    init = function()
      vim.o.foldenable = true
      vim.o.foldcolumn = '0' -- default is 1
      vim.o.foldlevelstart = 99
      -- vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      -- vim.o.foldmethod = 'manual' -- Default fold method (change as needed)
      -- vim.o.foldmethod = 'manual' -- Default fold method (change as needed)
    end,
    config = function()
      local ufo = require('ufo')
      ufo.setup({
        provider_selector = function(_, _, _)
          return { 'treesitter', 'indent' }
        end,
        open_fold_hl_timeout = 0, -- Disable highlight timeout after opening
      })

      -- za to fold at cursor location is already enabled
      nmap('zR', ufo.openAllFolds, { desc = 'Open All Folds' })
      nmap('zM', ufo.closeAllFolds, { desc = 'Close All Folds' })
    end,
  },
  {
    'HakonHarnes/img-clip.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { '<leader>pi', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
    },
  },
  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
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
    end,
  },
  {
    'uga-rosa/translate.nvim',
    keys = {
      {
        '<leader>tT',
        '<cmd>Translate Vi<cr>',
        mode = { 'n', 'v' },
        desc = 'Translate Text',
        silent = true,
      },
    },
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {},
    keys = {
      { '<leader>tt', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal', silent = true },
    },
  },
  {
    'uga-rosa/translate.nvim',
    keys = {
      {
        '<leader>tT',
        '<cmd>Translate Vi<cr>',
        mode = { 'n', 'v' },
        desc = 'Translate Text',
        silent = true,
      },
    },
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {},
    keys = {
      { '<leader>tt', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal', silent = true },
    },
  },
}
