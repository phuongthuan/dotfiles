vim.pack.add({
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('^1') },
  'https://github.com/MahanRahmati/blink-nerdfont.nvim',
})

require('blink.cmp').setup({
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  signature = { enabled = true },
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
      'lsp',
      'path',
      'snippets',
      'buffer',

      'nerdfont',
      -- 'copilot',
      -- 'dictionary',
    },
    providers = {
      snippets = {
        opts = {
          search_paths = { '~/.dotfiles/snippets' },
        },
      },
      -- copilot = {
      --   name = 'copilot',
      --   module = 'blink-cmp-copilot',
      --   score_offset = 100,
      --   async = true,
      -- },
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
      -- dictionary = {
      --   module = 'blink-cmp-dictionary',
      --   name = 'Dict',
      --   min_keyword_length = 3,
      --   opts = {
      --     dictionary_files = { vim.fn.expand('~/Library/dictionary/words_alpha.txt') },
      --   },
      --   should_show_items = function()
      --     return vim.tbl_contains({ 'text', 'markdown', 'gitcommit', 'codecompanion' }, vim.o.filetype)
      --   end,
      -- },
    },
  },
  cmdline = { sources = { 'cmdline' } },
  -- Disable per file type
  -- enabled = function()
  --   return not vim.tbl_contains({ 'codecompanion' }, vim.bo.filetype)
  --     and vim.bo.buftype ~= 'prompt'
  --     and vim.b.completion ~= false
  -- end,
})
