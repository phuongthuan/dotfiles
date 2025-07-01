local nmap = require('core.utils').mapper_factory('n')

nmap('<leader>tsc', function()
  require('smear_cursor').toggle()
  vim.notify('Toggle Smear Cursor ✔', vim.log.levels.INFO)
end, { desc = 'Toggle Smear Cursor' })

return {
  'sphamba/smear-cursor.nvim',
  opts = {
    smear_between_buffers = false,
    smear_insert_mode = false,
    smear_to_cmd = false,
  },
}
