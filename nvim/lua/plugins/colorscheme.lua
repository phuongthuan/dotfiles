return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  config = function()
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
  end,
}
