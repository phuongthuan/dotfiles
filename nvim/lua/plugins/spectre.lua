local nmap = require('core.utils').mapper_factory('n')

return {
  'nvim-pack/nvim-spectre',
  config = function()
    require('spectre').setup({
      mapping = {
        ['send_to_qf'] = {
          map = '<leader>qf',
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = 'send all items to quickfix',
        },
      },
    })

    -- Keymaps
    nmap(
      '<leader>sr',
      '<cmd>lua require("spectre").toggle()<cr>',
      { desc = 'Toggle Spectre' }
    )
    nmap(
      '<leader>sp',
      '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
      {
        desc = 'Search on current file',
      }
    )
    -- nmap(
    --   '<leader>sw',
    --   '<cmd>lua require("spectre").open_visual({select_word=true})<cr>',
    --   { desc = 'Search current word' }
    -- )
    -- vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<cr>', { desc = 'Search current word' })
  end,
}
