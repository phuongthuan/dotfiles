return {
  'folke/edgy.nvim',
  event = 'VeryLazy',
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = 'screen'
  end,
  opts = {
    animate = { enabled = false },
    left = {
      {
        ft = 'codecompanion',
        title = 'Copilot Chat  ',
        size = { width = 100 },
      },
    },
    bottom = {
      {
        ft = 'toggleterm',
        title = 'Terminal  ',
        size = { height = 0.4 },
        -- exclude floating windows
        filter = function(_, win)
          return vim.api.nvim_win_get_config(win).relative == ''
        end,
      },
    },
  },
}
