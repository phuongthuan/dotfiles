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
      prompt_title = '< Find Notes>',
      cwd = '~/vimwiki',
      hidden = true
    })
end

M.search_references = function()
    builtin.find_files({
      prompt_title = '< References >',
      cwd = '~/Programming/references',
      hidden = true
    })
end

return M
