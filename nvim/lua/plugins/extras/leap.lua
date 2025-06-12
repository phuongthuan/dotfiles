return {
  'ggandor/leap.nvim',
  keys = { 's', 'S', 'gs' },
  config = function()
    require('leap').set_default_keymaps()
  end,
}
