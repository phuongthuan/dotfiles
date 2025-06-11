local env = require('core.env')
local mapper = require('core.utils').mapper_factory
local nmap = mapper('n')

return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.ai').setup({ n_lines = 500 })
      require('mini.icons').setup()
      require('mini.pairs').setup()
      require('mini.starter').setup()
      require('mini.indentscope').setup()
      -- Hipatterns
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      -- Statusline
      local statusline = require('mini.statusline')
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- Files
      local files = require('mini.files')
      files.setup({
        mappings = {
          go_in = '<CR>',
          go_in_plus = 'L',
          go_out = '-',
          go_out_plus = 'H',
        },
      })
    end,
    keys = {
      {
        '<leader>ee',
        '<cmd>lua MiniFiles.open()<cr>',
        desc = 'Toggle mini files explorer',
        silent = true,
      },
      {
        '<leader>ef',
        '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<cr>',
        desc = 'Toggle current opened file',
        silent = true,
      },
    },
  },
}
