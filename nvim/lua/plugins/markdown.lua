return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'markdown', 'markdown_inline' } },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons',
    },
    ---@module 'render-markdown'
    ---@diagnostic disable-next-line: missing-fields
    ft = { 'markdown' },
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
      checkbox = { enabled = true },
      latex = { enabled = false },
    },
    keys = {
      { '<leader>tm', '<cmd>RenderMarkdown toggle<cr>', desc = 'Toggle Render Markdown', silent = true },
    },
  },
  {
    'toppair/peek.nvim',
    event = { 'VeryLazy' },
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup({ theme = 'light' })

      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
  },
}
