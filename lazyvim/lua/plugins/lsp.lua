return {
  {
    "williamboman/mason.nvim",
    keys = {
      { "<leader>cm", false },
      { "<leader>ms", "<cmd>Mason<cr>", desc = "Mason" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "lua",
        "ruby",
        "typescript",
        "markdown",
        "javascript",
      })
    end,
  },
}
