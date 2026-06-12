return {
  name = '(Overseer) yarn start --reset-cache',
  builder = function()
    return {
      cmd = { 'yarn', 'start', '--reset-cache' },
      components = { { 'on_complete_notify' }, 'default' },
    }
  end,
  condition = {
    dir = '~/p/',
  },
}
