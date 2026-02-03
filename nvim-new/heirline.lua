print('Heirline config loaded')

vim.pack.add({
  'https://github.com/rebelot/heirline.nvim',
  'https://github.com/nvim-mini/mini.icons',
})

local colors = require('utils').colors.gruvbox_dark
require('mini.icons').mock_nvim_web_devicons()

require('heirline.init').setup({
  winbar = require('heirline.winbar'),
  statusline = require('heirline.statusline'),
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
