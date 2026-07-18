vim.pack.add({ 'https://github.com/nvim-mini/mini.clue' })

local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers (explicit prefixes, excludes `<Leader>s`)
    { mode = { 'n', 'x' }, keys = '<Leader>a' },
    { mode = { 'n', 'x' }, keys = '<Leader>b' },
    { mode = { 'n', 'x' }, keys = '<Leader>c' },
    { mode = { 'n', 'x' }, keys = '<Leader>f' },
    { mode = { 'n', 'x' }, keys = '<Leader>p' },
    { mode = { 'n', 'x' }, keys = '<Leader>g' },
    { mode = { 'n', 'x' }, keys = '<Leader>h' },
    { mode = { 'n', 'x' }, keys = '<Leader>u' },

    -- `[` and `]` keys
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = { 'n', 'x' }, keys = 'g' },

    -- Marks
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },

    -- Registers
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = { 'n', 'x' }, keys = 'z' },
  },

  clues = {
    -- <Leader> mapping groups
    { mode = 'n', keys = '<Leader>a', desc = ' 󱚝 ' },
    { mode = 'n', keys = '<Leader>b', desc = ' Buffers' },
    { mode = 'n', keys = '<Leader>c', desc = ' Coding' },
    { mode = 'n', keys = '<Leader>f', desc = ' Files' },
    { mode = 'n', keys = '<Leader>p', desc = ' Search' },
    { mode = 'n', keys = '<Leader>u', desc = ' Options' },
    { mode = 'n', keys = '<Leader>g', desc = ' Git  ' },
    { mode = 'n', keys = '<Leader>h', desc = ' Git  ' },

    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})
