return {
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
}
