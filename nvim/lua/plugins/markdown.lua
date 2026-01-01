local colors = require('core.colors')

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'markdown', 'markdown_inline' } },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ---@module 'render-markdown'
    ft = { 'markdown' },
    init = function()
      local color1_bg = colors.green
      local color2_bg = colors.aqua
      local color3_bg = colors.light_blue
      local color_fg = colors.black

      vim.opt_local.spell = false
      vim.opt_local.spelllang = 'en'
      vim.opt_local.linebreak = true

      vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s gui=bold]], color_fg, color1_bg))
      vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s gui=bold]], color_fg, color2_bg))
      vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s gui=bold]], color_fg, color3_bg))
    end,
    opts = {
      heading = {
        enabled = false,
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
      completions = { blink = { enabled = true } },
      overrides = {
        filetype = {
          codecompanion = {
            html = {
              tag = {
                buf = { icon = ' ', highlight = 'CodeCompanionChatIcon' },
                file = { icon = ' ', highlight = 'CodeCompanionChatIcon' },
                group = { icon = ' ', highlight = 'CodeCompanionChatIcon' },
                help = { icon = '󰘥 ', highlight = 'CodeCompanionChatIcon' },
                image = { icon = ' ', highlight = 'CodeCompanionChatIcon' },
                rules = { icon = '󰧑 ', highlight = 'CodeCompanionChatIcon' },
                symbols = { icon = ' ', highlight = 'CodeCompanionChatIcon' },
                tool = { icon = '󰯠 ', highlight = 'CodeCompanionChatIcon' },
                url = { icon = '󰌹 ', highlight = 'CodeCompanionChatIcon' },
              },
            },
          },
        },
      },
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
