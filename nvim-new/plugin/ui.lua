vim.pack.add({
  'https://github.com/nvim-mini/mini.hipatterns',
  'https://github.com/nvim-mini/mini.starter',
  'https://github.com/nvim-mini/mini.icons',
  'https://github.com/nvim-mini/mini.notify',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/folke/todo-comments.nvim',
})

local colors = require('utils').colors.gruvbox_dark
local nmap = require('utils').nmap

require('mini.starter').setup()

require('mini.icons').setup({
  file = {
    ['.eslintrc.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
    ['.node-version'] = { glyph = '', hl = 'MiniIconsGreen' },
    ['.prettierrc'] = { glyph = '', hl = 'MiniIconsPurple' },
    ['eslint.config.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
    ['package.json'] = { glyph = '', hl = 'MiniIconsGreen' },
    ['tsconfig.json'] = { glyph = '', hl = 'MiniIconsAzure' },
    ['tsconfig.build.json'] = { glyph = '', hl = 'MiniIconsAzure' },
    ['.yarnrc.yml'] = { glyph = '', hl = 'MiniIconsBlue' },
    ['yarn.lock'] = { glyph = '', hl = 'MiniIconsBlue' },
  },
  filetype = {
    dotenv = { glyph = '', hl = 'MiniIconsYellow' },
  },
})

local hipatterns = require('mini.hipatterns')
hipatterns.setup({
  highlighters = {
    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

local notify = require('mini.notify')
notify.setup({
  window = {
    config = function()
      local has_statusline = vim.o.laststatus > 0
      local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
      return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - pad }
    end,
  },
})
nmap('<leader>om', function()
  notify.show_history()
end, { desc = 'Open Messages' })

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

require('render-markdown').setup({
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
})
nmap('<leader>tm', '<cmd>RenderMarkdown toggle<cr>', { desc = 'Toggle Render Markdown' })
