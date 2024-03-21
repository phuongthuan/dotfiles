return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = "true",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = string.rep("\n", 8) .. "Neovim :)" .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
