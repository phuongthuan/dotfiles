local builtin = require('telescope.builtin')

local M = {}

M.search_dotfiles = function()
    builtin.find_files({
      prompt_title = '< Dotfiles >',
      cwd = '~/.dotfiles',
      hidden = true,
    })
end

M.search_notes = function()
    builtin.live_grep({
      prompt_title = '< Notes >',
      cwd = '~/vimwiki',
      hidden = true
    })
end

M.search_note_files = function()
    builtin.find_files({
      prompt_title = '< Find Notes >',
      cwd = '~/vimwiki',
      hidden = true
    })
end

M.search_files_in_path = function(path)
  local _path = path or vim.fn.input("Directory: > ", "", "dir")
    builtin.find_files({
      search_dirs = { _path }
    })
end

M.live_grep_in_path = function(path)
  local _path = path or vim.fn.input("Directory: > ", "", "dir")
    builtin.live_grep({
      search_dirs = { _path }
    })
end

return M
