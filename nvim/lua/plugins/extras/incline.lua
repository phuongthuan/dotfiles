return {
  'b0o/incline.nvim',
  event = 'VeryLazy',
  dependencies = { 'echasnovski/mini.icons' },
  config = function()
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

        local icon = require('mini.icons').get('file', filename)
        local modified = vim.bo[props.buf].modified
        return {
          icon and { ' ', icon } or '',
          ' ',
          { filename, gui = modified and 'bold,italic' or 'regular' },
          ' ',
          guibg = '#3c3836',
          guifg = '#bdae93',
        }
      end,
    })
  end,
}
