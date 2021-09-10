-----------------------------------------------------------
-- Nvim autopairs
-----------------------------------------------------------

-- nvim-autopairs
--- https://github.com/windwp/nvim-autopairs

local npairs = require('nvim-autopairs')

npairs.setup({
  check_ts = true,
})

require('nvim-autopairs.completion.cmp').setup({
  map_cr = true,
})
