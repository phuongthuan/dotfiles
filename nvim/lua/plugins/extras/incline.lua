return {
  -- Adding a filename to the top right corner
  'b0o/incline.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local helpers = require('incline.helpers')
    local devicons = require('nvim-web-devicons')

    require('incline').setup({
      hide = {
        only_win = false,
      },
      window = {
        margin = {
          vertical = 1,
          horizontal = 0,
        },
        placement = {
          horizontal = 'right',
          vertical = 'top',
        },
      },
      render = function(props)
        local bufname = vim.api.nvim_buf_get_name(props.buf)
        local filename = vim.fn.fnamemodify(bufname, ':t')

        if filename == '' then
          filename = '[No Name]'
        end

        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        return {
          ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
          ' ',
          { filename, gui = modified and 'bold,italic' or 'regular' },
          ' ',
          -- guibg = '#282828',
        }
      end,
    })
  end,
}
