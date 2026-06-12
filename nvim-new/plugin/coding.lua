vim.pack.add({
  'https://github.com/nvim-mini/mini.pairs',
  'https://github.com/nvim-mini/mini.jump2d',
  'https://github.com/nvim-mini/mini.ai',
  'https://github.com/windwp/nvim-ts-autotag',
  'https://github.com/Beargruug/xls-viewer.nvim',
})

-- mini.pairs
require('mini.pairs').setup({
  modes = { command = true },
})

-- mini.jump2d
require('mini.jump2d').setup({
  mappings = { start_jumping = 's' },
  allowed_lines = { blank = false },
  allowed_windows = { not_current = false },
  silent = true,
})

-- mini.ai
require('mini.ai').setup({ n_lines = 500 })

-- nvim-ts-autotag
require('nvim-ts-autotag').setup()

-- xls-viewer
require('xls-viewer').setup({
  python_cmd = '/opt/homebrew/bin/python3',
})
