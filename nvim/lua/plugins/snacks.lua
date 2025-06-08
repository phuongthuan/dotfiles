return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    image = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = false },
    explorer = { enabled = false },
    picker = { enabled = false },
    statuscolumn = { enabled = false },
    toggle = { enabled = false },
    words = { enabled = false },
    notifier = { enabled = false },
    lazygit = { enabled = false },
    input = { enabled = false },
    rename = { enabled = false },
  },
  keys = {
    {
      '<leader>rN',
      '<cmd>lua require("snacks").rename.rename_file()<cr>',
      desc = 'Fast rename current file',
    },
  },
}
