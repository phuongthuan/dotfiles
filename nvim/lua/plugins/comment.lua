---@diagnostic disable: undefined-global
return {
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

        FIX = { icon = ' ', color = '#cc241d', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' } }, -- FIX: fix
        TODO = { icon = ' ', color = '#83a598' },
        HACK = { icon = ' ', color = '#fabd2f', alt = { 'DON SKIP' } },
        WARN = { icon = ' ', color = '#fabd2f', alt = { 'WARNING', 'XXX' } },
        PERF = { icon = ' ', alt = { '#83a598', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = ' ', color = '#8ec07c', alt = { 'INFO', 'READ', 'COLORS' } },
        TEST = { icon = '⏲ ', color = '#83a598', alt = { 'TESTING', 'PASSED', 'FAILED' } },
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
        '<leader>ttl',
        function()
          ---@diagnostic disable-next-line: undefined-field
          require('snacks').picker.todo_comments()
        end,
        desc = 'Toggle Todo Lists',
      },
    },
  },
  {
    'echasnovski/mini.comment',
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
}
