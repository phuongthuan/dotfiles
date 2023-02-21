local map = vim.keymap.set

require('git-worktree').setup{}

map('n', '<leader>cw', ':lua require("git-worktree").create_worktree("feat-69", "master", "origin")')
