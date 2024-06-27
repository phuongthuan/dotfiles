return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<C-f>', '<cmd>Neotree reveal<cr>', { desc = 'NeoTree reveal', silent = true } },
    { '<C-b>', '<cmd>Neotree toggle<cr>', { desc = 'NeoTree toggle', silent = true } },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['<C-b>'] = 'close_window',
        },
      },
    },
  },
}
