return {
  'echasnovski/mini.statusline',
  version = false,
  config = function()
    local statusline = require('mini.statusline')
    statusline.setup({ use_icons = vim.g.have_nerd_font })

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
