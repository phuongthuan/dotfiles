vim.pack.add({
  'https://github.com/rebelot/heirline.nvim',
})

local colors = require('utils').colors.gruvbox_dark
require('mini.icons').mock_nvim_web_devicons()

require('heirline').setup({
  -- winbar = require('plugin.heirline.winbar'),
  -- statusline = require('plugin.heirline.statusline'),
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
