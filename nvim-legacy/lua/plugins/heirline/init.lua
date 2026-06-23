local colors = require('core.colors')

return {
  'rebelot/heirline.nvim',
  event = 'UiEnter',
  init = function()
    require('mini.icons').setup()
    require('mini.icons').mock_nvim_web_devicons()
  end,
  config = function()
    require('heirline').setup({
      winbar = require('plugins.heirline.winbar'),
      statusline = require('plugins.heirline.statusline'),
      colors = colors,
      opts = {
        disable_winbar_cb = function(args)
          local conditions = require('heirline.conditions')

          return conditions.buffer_matches({
            buftype = { 'nofile', 'prompt', 'help', 'quickfix', 'terminal' },
            filetype = { '^git.*', 'lspinfo', 'minifiles', 'codecompanion', 'toggleterm' },
          }, args.buf)
        end,
      },
    })
  end,
}
