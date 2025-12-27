local icons = require('core.icons')

return {
  'nvim-lualine/lualine.nvim',
  enabled = false,
  dependencies = { 'echasnovski/mini.icons' },
  opts = {
    options = {
      theme = 'gruvbox',
      icons_enabled = true,
      section_separators = { '', '' },
      component_separators = { '', '' },
      disabled_filetypes = {},
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = { 'filename' },
      lualine_x = {
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          symbols = icons.diagnostics,
        },
        'encoding',
        'filetype',
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
  },
}
