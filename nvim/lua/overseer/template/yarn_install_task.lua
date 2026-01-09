return {
  name = 'yarn install',
  builder = function()
    return {
      cmd = { 'yarn', 'install' },
      components = { { 'on_complete_notify' }, 'default' },
    }
  end,
  condition = {
    dir = '~/p/',
  },
}
