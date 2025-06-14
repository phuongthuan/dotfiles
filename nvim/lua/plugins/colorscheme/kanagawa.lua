return {
  'rebelot/kanagawa.nvim',
  branch = 'master',
  priority = 1000,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('kanagawa').setup({
      transparent = true,
    })
    vim.o.background = 'dark'
    vim.cmd.colorscheme('kanagawa')
  end,
}
