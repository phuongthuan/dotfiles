return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    image = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
  },
  keys = {
    {
      '<leader>rN',
      function()
        require('snacks').rename.rename_file()
      end,
      desc = 'Fast Rename Current File',
    },
  },
}
