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
    builtin.find_files({
      prompt_title = '< Notes >',
      cwd = '~/vimwiki',
      hidden = true
    })
end

return M
