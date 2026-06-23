return {
  'ggandor/leap.nvim',
  enabled = false,
  keys = { 's', 'S', 'gs' },
  config = function()
    require('leap').set_default_keymaps()
  end,
}
