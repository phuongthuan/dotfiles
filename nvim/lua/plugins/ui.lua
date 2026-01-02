local colors = require('core.colors')

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
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      -- Enabled plugins
      image = { enabled = true },
      quickfile = { enabled = true },
      rename = { enabled = true },
      bufdelete = { enabled = true },
      gitbrowse = { enabled = true },

      -- Disabled plugins
      scroll = { enabled = false },
      explorer = { enabled = false },
      picker = { enabled = false },
      statuscolumn = { enabled = false },
      toggle = { enabled = false },
      words = { enabled = false },
      notifier = { enabled = false },
      lazygit = { enabled = false },
      input = { enabled = false },
      dashboard = { enabled = false },
      scratch = { enabled = false },
      terminal = { enabled = false },
      indent = { enabled = false },
    },
    keys = {
      {
        '<leader>rN',
        function()
          Snacks.rename.rename_file()
        end,
        desc = 'Fast Rename Current File',
      },
      {
        '<leader>z',
        function()
          Snacks.bufdelete.delete()
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>Z',
        function()
          Snacks.bufdelete.other()
        end,
        desc = 'Delete All Buffers Except Current',
      },
      {
        '<leader>gob',
        function()
          vim.ui.input({ prompt = ' Branch' }, function(branch)
            -- User pressed <Esc> (cancel input)
            if branch == nil then
              return
            end

            -- User pressed Enter without typing (empty string)
            if branch == '' then
              branch = nil
            end

            Snacks.gitbrowse({ branch = branch })
          end)
        end,
        mode = { 'n', 'v' },
        desc = 'Git Browse URL',
      },
    },
  },
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      keywords = {
        -- TODO: todo
        -- FIX: fix
        -- HACK: hack
        -- WARN: warn
        -- NOTE: note
        -- TEST: test
        -- PERF: perf

        FIX = { icon = ' ', color = colors.red, alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' } }, -- FIX: fix
        TODO = { icon = ' ', color = colors.light_blue },
        HACK = { icon = ' ', color = colors.yellow, alt = { 'DON SKIP' } },
        WARN = { icon = ' ', color = colors.yellow, alt = { 'WARNING', 'XXX' } },
        PERF = { icon = ' ', alt = { colors.light_blue, 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = ' ', color = colors.aqua, alt = { 'INFO', 'READ', 'COLORS' } },
        TEST = { icon = '⏲ ', color = colors.light_blue, alt = { 'TESTING', 'PASSED', 'FAILED' } },
      },
    },
    keys = {
      {
        ']t',
        function()
          todo_comments.jump_next()
        end,
        desc = 'Next Todo Comment',
      },
      {
        '[t',
        function()
          todo_comments.jump_prev()
        end,
        desc = 'Prev Todo Comment',
      },
      {
        '<leader>tc',
        function()
          ---@diagnostic disable-next-line: undefined-field
          require('snacks').picker.todo_comments()
        end,
        desc = 'Toggle Todo Comments',
      },
    },
  },
  {
    'nvim-mini/mini.comment',
    version = false,
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      -- skip backwards compatibility routines and speed up loading
      vim.g.skip_ts_context_commentstring_module = true

      -- disable the autocommand from ts-context-commentstring
      require('ts_context_commentstring').setup({
        enable_autocmd = false,
      })

      require('mini.comment').setup({
        -- tsx, jsx, html , svelte comment support
        options = {
          custom_commentstring = function()
            ---@diagnostic disable-next-line: missing-fields
            return require('ts_context_commentstring.internal').calculate_commentstring({
              key = 'commentstring',
            }) or vim.bo.commentstring
          end,
        },
      })
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ---@module 'render-markdown'
    ft = { 'markdown', 'codecompanion' },
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
}
