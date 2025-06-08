return {
  'MeanderingProgrammer/render-markdown.nvim',
  enabled = true,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  ---@module 'render-markdown'
  ft = { 'markdown', 'copilot-chat' },
  init = function()
    local color1_bg = '#b8bb26'
    local color2_bg = '#8ec07c'
    local color3_bg = '#83a598'
    local color_fg = '#282828'

    vim.opt_local.spell = false
    vim.opt_local.spelllang = 'en'
    vim.opt_local.linebreak = true

    vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s gui=bold]], color_fg, color1_bg))
    vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s gui=bold]], color_fg, color2_bg))
    vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s gui=bold]], color_fg, color3_bg))
  end,
  opts = {
    latex = { enabled = false },
    heading = {
      sign = false,
      icons = { '󰎤 ', '󰎧 ', '󰎪 ', '󰎭 ', '󰎱 ', '󰎳 ' },
      backgrounds = {
        'Headline1Bg',
        'Headline2Bg',
        'Headline3Bg',
      },
      foregrounds = {
        'Headline1Fg',
        'Headline2Fg',
        'Headline3Fg',
      },
    },
    code = {
      sign = false,
      width = 'block',
      right_pad = 1,
    },
    bullet = { enabled = true },
  },
}
