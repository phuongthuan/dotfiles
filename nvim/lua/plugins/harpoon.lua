local mapper = require('core.utils').mapper_factory
local nmap = mapper('n')

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require('harpoon')

    harpoon:setup({
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
      },
    })

    harpoon:extend({
      UI_CREATE = function(cx)
        nmap('<C-v>', function()
          harpoon.ui:select_menu_item({ vsplit = true })
        end, { buffer = cx.bufnr })

        nmap('<C-h>', function()
          harpoon.ui:select_menu_item({ split = true })
        end, { buffer = cx.bufnr })
      end,
    })
  end,
  keys = {
    {
      '<C-a>',
      function()
        local harpoon = require('harpoon')
        harpoon:list():add()
        vim.notify('Added to bookmarks ✔', vim.log.levels.INFO, { title = 'Harpoon' })
      end,
      desc = 'Harpoon: Add file to bookmarks',
      silent = true,
    },
    {
      '<C-e>',
      function()
        local harpoon = require('harpoon')
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = 'Harpoon: Toggle quick menu',
      silent = true,
    },
    {
      '<leader>1',
      function()
        local harpoon = require('harpoon')
        harpoon:list():select(1)
      end,
      desc = 'Harpoon: Navigate to file 1',
      silent = true,
    },
    {
      '<leader>2',
      function()
        local harpoon = require('harpoon')
        harpoon:list():select(2)
      end,
      desc = 'Harpoon: Navigate to file 2',
      silent = true,
    },
    {
      '<leader>3',
      function()
        local harpoon = require('harpoon')
        harpoon:list():select(3)
      end,
      desc = 'Harpoon: Navigate to file 3',
      silent = true,
    },
    {
      '<leader>4',
      function()
        local harpoon = require('harpoon')
        harpoon:list():select(4)
      end,
      desc = 'Harpoon: Navigate to file 4',
      silent = true,
    },
    {
      '<leader>5',
      function()
        local harpoon = require('harpoon')
        harpoon:list():select(5)
      end,
      desc = 'Harpoon: Navigate to file 5',
      silent = true,
    },
  },
}
