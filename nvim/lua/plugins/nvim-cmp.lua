-----------------------------------------------------------
-- Autocomplete configuration file
-----------------------------------------------------------

-- Plugin: nvim-cmp
--- https://github.com/hrsh7th/nvim-cmp

local cmp = require('cmp')

cmp.setup {
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'treesitter' },
    { name = 'spell' },
  },
}

