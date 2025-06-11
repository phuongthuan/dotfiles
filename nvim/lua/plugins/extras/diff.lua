return {
  'echasnovski/mini.diff',
  version = false,
  config = function()
    require('mini.diff').setup({
      mappings = {
        -- Apply hunks inside a visual/operator region
        apply = 'ghs',

        -- Reset hunks inside a visual/operator region
        reset = 'ghr',

        -- Hunk range textobject to be used inside operator
        -- Works also in Visual mode if mapping differs from apply and reset
        textobject = 'ghS',

        -- Go to hunk range in corresponding direction
        goto_prev = '[c',
        goto_next = ']c',
      },
    })
  end,
  keys = {
    {
      '<leader>pv',
      function()
        MiniDiff.toggle_overlay()
      end,
      desc = 'MiniDiff Toggle Hunk',
      silent = true,
    },
  },
}
