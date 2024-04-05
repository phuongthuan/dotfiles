return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-telescope/telescope-file-browser.nvim",
  },
  keys = {
    { "<leader>fr", false },
    { "<leader>sR", false },
    { "<leader>?", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    { "<leader>rs", "<cmd>Telescope resume<cr>", desc = "Resume" },
    {
      "<leader>fP",
      function()
        local builtin = require("telescope.builtin")
        builtin.find_files({
          propmt_title = " Plugin Files",
          cwd = require("lazy.core.config").options.root,
        })
      end,
      desc = "Find plugin files",
    },
    {
      ";f",
      function()
        local builtin = require("telescope.builtin")
        builtin.find_files({
          propmt_title = " Files",
          no_ignore = false,
          hidden = true,
        })
      end,
      desc = "Lists files in the current working directory, respects .gitignore",
    },
    {
      ";r",
      function()
        local builtin = require("telescope.builtin")
        builtin.live_grep({
          propmt_title = " Grep String",
          additional_args = { "--hidden" },
        })
      end,
      desc = "Search for a string in the current working directory and get results live as typed, respects .gitignore",
    },
    {
      "<leader>ps",
      function()
        local builtin = require("telescope.builtin")
        builtin.grep_string({
          search = vim.fn.input("Grep > "),
          additional_args = { "--hidden" },
        })
      end,
      desc = "Search for a input string in the current working directory, respects .gitignore",
    },
    {
      "<leader>sn",
      function()
        local builtin = require("telescope.builtin")
        local variable = require("phuongthuan.variable")
        builtin.live_grep({
          prompt_title = " Grep Notes",
          cwd = variable.icloud_drive_obsidian_path,
          layout_config = { preview_width = 0.65 },
          hidden = true,
        })
      end,
      desc = "Search for a string in the note folder",
    },
    {
      "<leader>fn",
      function()
        local builtin = require("telescope.builtin")
        local variable = require("phuongthuan.variable")
        builtin.find_files({
          prompt_title = " Note Files",
          cwd = variable.icloud_drive_obsidian_path,
          hidden = true,
        })
      end,
      desc = "Lists note files",
    },
    {
      "<leader>sdf",
      function()
        local builtin = require("telescope.builtin")
        local variable = require("phuongthuan.variable")
        builtin.find_files({
          prompt_title = " Dotfiles",
          cwd = variable.dotfiles_path,
          hidden = true,
        })
      end,
      desc = "Search .dotfiles",
    },
    {
      "<leader>gb",
      function()
        local builtin = require("telescope.builtin")
        builtin.git_branches()
      end,
      desc = "Search git branches",
    },
    {
      ";d",
      function(path)
        local builtin = require("telescope.builtin")
        local _path = path or vim.fn.input("Directory: > ")
        builtin.live_grep({
          search_dirs = { _path },
          prompt_title = " Grep in Directory",
          additional_args = { "--hidden" },
        })
      end,
      desc = "Search for a input string in the given directory, respects .gitignore",
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
      winblend = 0,
      file_ignore_patterns = { "node_modules", ".git/" },
      layout_config = {
        width = 0.95,
        height = 0.85,
        horizontal = {
          preview_width = function(_, cols, _)
            if cols > 200 then
              return math.floor(cols * 0.4)
            else
              return math.floor(cols * 0.6)
            end
          end,
        },
        vertical = {
          width = 0.9,
          height = 0.95,
          preview_height = 0.5,
        },
        flex = {
          horizontal = {
            preview_width = 0.9,
          },
        },
      },
      mappings = {
        i = {
          ["<C-x>"] = false,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<Esc>"] = actions.close,
        },
      },
    })
    opts.pickers = {
      find_files = {
        previewer = false,
        hidden = true,
      },
      buffers = {
        theme = "ivy",
        previewer = false,
      },
    }
    telescope.setup(opts)
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")
  end,
}
