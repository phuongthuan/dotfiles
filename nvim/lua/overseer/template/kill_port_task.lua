return {
  name = '(Overseer) kill_port 8081',
  builder = function()
    return {
      cmd = { 'bash', '-c', '~/scripts/kill-port.sh 8081' },
      components = { { 'on_complete_notify' }, 'default' },
    }
  end,
  condition = {
    dir = { '~/p/', '~/.treehouse/' },
  },
}
