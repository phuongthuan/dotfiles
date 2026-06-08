vim.pack.add({
  { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
  'https://github.com/nvim-lua/plenary.nvim',
})

local nmap = require('utils').nmap
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

nmap('<C-a>', function()
  harpoon:list():add()
  print('Added a file to bookmarks ✔')
end, { desc = 'Harpoon - Add file to bookmarks', silent = true })

nmap('<C-e>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Harpoon - Toggle Quick Menu', silent = true })

nmap('<leader>1', function()
  harpoon:list():select(1)
end, { desc = 'Harpoon - Navigate To File 1', silent = true })
nmap('<leader>2', function()
  harpoon:list():select(2)
end, { desc = 'Harpoon - Navigate To File 2', silent = true })
nmap('<leader>3', function()
  harpoon:list():select(3)
end, { desc = 'Harpoon - Navigate To File 3', silent = true })
nmap('<leader>4', function()
  harpoon:list():select(4)
end, { desc = 'Harpoon - Navigate To File 4', silent = true })
nmap('<leader>5', function()
  harpoon:list():select(5)
end, { desc = 'Harpoon - Navigate To File 5', silent = true })
