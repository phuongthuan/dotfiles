vim.pack.add({
  'https://github.com/ellisonleao/gruvbox.nvim',
})

require('gruvbox').setup({
  transparent_mode = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = false,
  },
})

vim.o.background = 'dark'
vim.cmd.colorscheme('gruvbox')
