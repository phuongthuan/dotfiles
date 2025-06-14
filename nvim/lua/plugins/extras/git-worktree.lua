return {
  'ThePrimeagen/git-worktree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('git-worktree').setup()
    require('telescope').load_extension('git_worktree')
  end,
  keys = {
    -- <Enter> - switches to that worktree
    -- <c-d> - deletes that worktree
    -- <c-f> - toggles forcing of the next deletion
    {
      '<leader>wl',
      function()
        require('telescope').extensions.git_worktree.git_worktrees()
      end,
      { desc = 'Git Worktree List' },
    },
    {
      '<leader>wc',
      function()
        require('telescope').extensions.git_worktree.create_git_worktree()
      end,
      { desc = 'Create Git Worktree Branches' },
    },
  },
}
