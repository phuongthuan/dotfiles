local nmap = require('core.utils').mapper_factory('n')

-- -- Auto update cursor color when switching between modes (config for smear-cursor)
-- vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
--   callback = function()
--     if vim.tbl_contains({ 'i', 'r', 'v', 'ci' }, vim.fn.mode()) then
--       vim.api.nvim_set_hl(0, 'cursori', { fg = '#fb4934', bg = '#fb4934' })
--       vim.opt.guicursor = {
--         'i:block-cursori',
--         'r:block-cursori',
--         'v:block-cursori',
--         'ci:block-cursori',
--       }
--     end
--   end,
-- })

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
    -- cursor_color = '#fbf1c7',
    -- stiffness = 0.5,
    -- trailing_stiffness = 0.5,
    -- filetypes_disabled = { 'copilot-chat', 'codecompanion' },
  },
}
