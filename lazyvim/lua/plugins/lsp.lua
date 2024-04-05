return {
  {
    "williamboman/mason.nvim",
    keys = {
      { "<leader>cm", false },
      { "<leader>ms", "<cmd>Mason<cr>", desc = "Mason" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        solargraph = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ruby",
      })
    end,
  },
}
