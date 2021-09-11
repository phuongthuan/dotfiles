-----------------------------------------------------------
-- Nvim autopairs
-----------------------------------------------------------

-- nvim-autopairs
--- https://github.com/windwp/nvim-autopairs

require('nvim-autopairs').setup({
  check_ts = true,
})

require('nvim-autopairs.completion.cmp').setup({
  map_cr = true,
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = false,
})

