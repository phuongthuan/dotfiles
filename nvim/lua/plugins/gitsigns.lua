local mapper = require('core.utils').mapper_factory
local nmap = mapper('n')

return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    signcolumn = true,
    current_line_blame = true,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      nmap(']c', gs.next_hunk, { buffer = bufnr, desc = 'Next Hunk' })
      nmap('[c', gs.prev_hunk, { buffer = bufnr, desc = 'Prev Hunk' })

      mapper({ 'n', 'v' })(
        '<leader>hs',
        ':Gitsigns stage_hunk<CR>',
        { buffer = bufnr, desc = 'Stage Hunk' }
      )

      mapper({ 'n', 'v' })(
        '<leader>hr',
        ':Gitsigns reset_hunk<CR>',
        { buffer = bufnr, desc = 'Reset Hunk' }
      )

      nmap(
        '<leader>hS',
        gs.stage_buffer,
        { buffer = bufnr, desc = 'Stage Buffer' }
      )
      nmap(
        '<leader>hu',
        gs.undo_stage_hunk,
        { buffer = bufnr, desc = 'Undo Stage Hunk' }
      )

      nmap(
        '<leader>pv',
        gs.preview_hunk_inline,
        { buffer = bufnr, desc = 'Preview Hunk Inline' }
      )

      nmap('<leader>hb', function()
        gs.blame_line({ full = true })
      end, { buffer = bufnr, desc = 'Blame Line' })

      nmap('<leader>hd', gs.diffthis, { buffer = bufnr, desc = 'Diff This' })
    end,
  },
}
