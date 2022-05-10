local builtin = require("telescope.builtin")

local M = {}

M.search_dotfiles = function()
    builtin.find_files({
      prompt_title = " Dotfiles",
      cwd = "~/.dotfiles",
      -- hidden = true,
    })
end

M.search_references = function()
    builtin.find_files({
      prompt_title = "< References >",
      cwd = "~/Programming/references/",
      hidden = true,
    })
end

M.search_notes = function()
    builtin.live_grep({
      prompt_title = " Grep Notes",
      prompt_prefix = " ﮷ ",
      cwd = "~/vimwiki",
      hidden = true,
    })
end

M.search_note_files = function()
    builtin.find_files({
      prompt_title = " Find Notes",
      prompt_prefix = " ﮷ ",
      cwd = "~/vimwiki",
      hidden = true
    })
end

M.search_files_in_path = function(path)
  local _path = path or vim.fn.input("Directory: > ", "", "dir")
    builtin.find_files({
      search_dirs = { _path },
      prompt_title = " Files",
    })
end


-- Keymap: space + l + i
M.live_grep_in_path = function(path)
  local _path = path or vim.fn.input("Directory: > ", "", "dir")
    builtin.live_grep({
      search_dirs = { _path },
      prompt_title = " Grep Strings",
      -- layout_config = { preview_width = 0.55, width = 0.85 },
    })
end

M.file_explorer = function()
  require("telescope").extensions.file_browser.file_browser {
    prompt_title = " File Browser",
    path_display = { "smart" },
    cwd = "~",
  }
end

return M
