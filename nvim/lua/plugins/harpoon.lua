return {
  'ThePrimeagen/harpoon',
  opts = {
    menu = {
      width = 100,
    },
  },
  keys = {
    {
      '<C-a>',
      '<cmd>lua require("harpoon.mark").add_file()<cr>:echo " Bookmarked 🌟"<cr>',
      desc = 'Harpoon: Add file to bookmarks',
      silent = true,
    },
    {
      '<C-e>',
      '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>',
      desc = 'Harpoon: Toggle quick menu',
      silent = true,
    },
    {
      '<leader>1',
      '<cmd>lua require("harpoon.ui").nav_file(1)<cr>',
      desc = 'Harpoon: Navigate to file 1',
      silent = true,
    },
    {
      '<leader>2',
      '<cmd>lua require("harpoon.ui").nav_file(2)<cr>',
      desc = 'Harpoon: Navigate to file 2',
      silent = true,
    },
    {
      '<leader>3',
      '<cmd>lua require("harpoon.ui").nav_file(3)<cr>',
      desc = 'Harpoon: Navigate to file 3',
      silent = true,
    },
    {
      '<leader>4',
      '<cmd>lua require("harpoon.ui").nav_file(4)<cr>',
      desc = 'Harpoon: Navigate to file 4',
      silent = true,
    },
    {
      '<leader>5',
      '<cmd>lua require("harpoon.ui").nav_file(5)<cr>',
      desc = 'Harpoon: Navigate to file 5',
      silent = true,
    },
    {
      '<leader>6',
      '<cmd>lua require("harpoon.ui").nav_file(5)<cr>',
      desc = 'Harpoon: Navigate to file 5',
      silent = true,
    },
  },
}
