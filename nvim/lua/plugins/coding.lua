return {
  'nvim-mini/mini.pairs',
  {
    'nvim-mini/mini.jump2d',
    opts = {
      mappings = { start_jumping = 's' },
      allowed_lines = { blank = false },
      allowed_windows = { not_current = false },
      silent = true,
    },
  },
  {
    'nvim-mini/mini.ai',
    opts = { n_lines = 500 },
  },
}
