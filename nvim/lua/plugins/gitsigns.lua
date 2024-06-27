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
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      map('n', ']c', gs.next_hunk, 'Next Hunk')
      map('n', '[c', gs.prev_hunk, 'Prev Hunk')
      map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
      map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
      map('n', '<leader>hS', gs.stage_buffer, 'Stage Buffer')
      map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo Stage Hunk')
      map('n', '<leader>pv', gs.preview_hunk_inline, 'Preview Hunk Inline')
      map('n', '<leader>hb', function()
        gs.blame_line { full = true }
      end, 'Blame Line')
      map('n', '<leader>hd', gs.diffthis, 'Diff This')
    end,
  },
}
