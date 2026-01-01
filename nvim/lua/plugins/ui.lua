return {
  { 'nvim-mini/mini.starter', opts = { silent = true } },
  {
    'nvim-mini/mini.indentscope',
    opts = {
      symbol = '┆', -- alternative styles: ┆ ┊ ╎
    },
  },
  {
    'nvim-mini/mini.icons',
    opts = {
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
    },
  },
  {
    'nvim-mini/mini.hipatterns',
    opts = {
      highlighters = {
        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
      },
    },
  },

  --   local hipatterns = require('mini.hipatterns')
  -- hipatterns.setup({
  --   highlighters = {
  --     -- Highlight hex color strings (`#rrggbb`) using that color
  --     hex_color = hipatterns.gen_highlighter.hex_color(),
  --   },
  -- })
}
