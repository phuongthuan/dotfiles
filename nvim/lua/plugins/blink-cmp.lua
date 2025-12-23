return {
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      'folke/lazydev.nvim',
      'giuxtaposition/blink-cmp-copilot',
      'moyiz/blink-emoji.nvim',
      'MahanRahmati/blink-nerdfont.nvim',
      'Kaiser-Yang/blink-cmp-dictionary',
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'none',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'cancel', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },

        ['<Tab>'] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          'snippet_forward',
          'fallback',
        },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },

      appearance = { nerd_font_variant = 'mono' },
      completion = { documentation = { auto_show = false } },
      sources = {
        default = {
          -- built-in sources
          'lsp',
          'path',
          'snippets',
          'buffer',

          -- extra sources
          'lazydev',
          'copilot',
          'emoji',
          'nerdfont',

          'dictionary',
        },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            score_offset = 100,
            async = true,
          },
          emoji = {
            module = 'blink-emoji',
            name = 'Emoji',
            score_offset = 15,
            opts = {
              insert = true,
              ---@type string|table|fun():table
              trigger = function()
                return { ':' }
              end,
            },
            should_show_items = function()
              -- Enable emoji completion for a set of file-types
              return vim.tbl_contains({ 'gitcommit', 'markdown', 'yml', 'yaml' }, vim.o.filetype)
            end,
          },
          nerdfont = {
            module = 'blink-nerdfont',
            name = 'Nerd Fonts',
            score_offset = 15,
            opts = { insert = true },
            should_show_items = function()
              -- Enable nerdfont completion for a set of file-types
              return vim.tbl_contains({ 'lua', 'zsh', 'toml', 'tmux' }, vim.o.filetype)
            end,
          },
          dictionary = {
            module = 'blink-cmp-dictionary',
            name = 'Dict',
            min_keyword_length = 3,
            opts = {
              dictionary_files = { vim.fn.expand('~/Library/dictionary/words_alpha.txt') },
            },
            should_show_items = function()
              return vim.tbl_contains({ 'text', 'markdown', 'gitcommit', 'codecompanion' }, vim.o.filetype)
            end,
          },
        },
      },

      cmdline = { enabled = false },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
      signature = { enabled = false },

      -- Disable per file type
      -- enabled = function()
      --   return not vim.tbl_contains({ 'copilot-chat' }, vim.bo.filetype)
      --     and vim.bo.buftype ~= 'prompt'
      --     and vim.b.completion ~= false
      -- end,
    },
    opts_extend = { 'sources.default' },
  },
}
