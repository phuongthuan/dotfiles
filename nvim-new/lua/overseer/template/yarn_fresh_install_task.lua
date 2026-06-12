return {
  name = '(Overseer) yarn fresh install',
  builder = function()
    return {
      cmd = { 'bash', '-c', 'rm -rf node_modules && yarn cache clean && yarn install' },
      components = { { 'on_complete_notify' }, 'default' },
    }
  end,
  condition = {
    dir = '~/p/',
  },
}
