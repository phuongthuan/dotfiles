local mapper = require('core.utils').mapper_factory
local nmap = mapper('n')

return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.ai').setup({ n_lines = 500 })
    require('mini.icons').setup()
    require('mini.pairs').setup()

    require('mini.tabline').setup()

    require('mini.starter').setup({ silent = true })

    require('mini.indentscope').setup({
      -- Which character to use for drawing scope indicator
      -- alternative styles: ┆ ┊ ╎
      symbol = '┆',
    })

    require('mini.jump2d').setup({
      mappings = { start_jumping = 's' },
      allowed_lines = { blank = false },
      allowed_windows = { not_current = false },
      silent = true,
    })

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

    nmap('<leader>ee', function()
      files.open()
    end, { desc = 'MiniFiles - Toggle Files Explorer' })

    nmap('<leader>ef', function()
      files.open(vim.api.nvim_buf_get_name(0), false)
    end, { desc = 'MiniFiles - Toggle Current Opened File' })
  end,
}
