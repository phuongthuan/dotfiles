local map = vim.keymap.set

require('git-worktree').setup{}

map('n', '<leader>cw', ':lua require("git-worktree").create_worktree("feat-69", "master", "origin")')
map('n', '<leader>cw', ':lua require("telescope").extensions.git_worktree.create_git_worktree()<CR>')
