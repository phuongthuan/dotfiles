local nmap = require('core.utils').mapper_factory('n')

return {
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local todo_comments = require('todo-comments')

      todo_comments.setup({
        keywords = {
          FIX = {
            icon = ' ',
            color = 'error', -- can be a hex color, or a named color (see below)
            alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = ' ', color = 'info' },
          HACK = { icon = ' ', color = 'warning', alt = { 'DON SKIP' } },
          WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
          PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
          NOTE = { icon = ' ', color = 'hint', alt = { 'INFO', 'READ', 'COLORS' } },
          TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
        },
      })

      -- Keymaps
      nmap(']t', function()
        todo_comments.jump_next()
      end, { desc = 'Next Todo Comment' })

      nmap('[t', function()
        todo_comments.jump_prev()
      end, { desc = 'Previous Todo Comment' })
    end,
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
