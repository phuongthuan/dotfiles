---@diagnostic disable: undefined-global
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    -- Enabled plugins
    image = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    bufdelete = { enabled = true },
    gitbrowse = { enabled = true },

    -- Disabled plugins
    scroll = { enabled = false },
    explorer = { enabled = false },
    picker = { enabled = false },
    statuscolumn = { enabled = false },
    toggle = { enabled = false },
    words = { enabled = false },
    notifier = { enabled = false },
    lazygit = { enabled = false },
    input = { enabled = false },
    dashboard = { enabled = false },
    scratch = { enabled = false },
    terminal = { enabled = false },
    indent = { enabled = false },
  },
  keys = {
    {
      '<leader>rN',
      function()
        Snacks.rename.rename_file()
      end,
      desc = 'Fast rename current file',
    },
    {
      '<leader>z',
      function()
        Snacks.bufdelete.delete()
      end,
      desc = 'Delete current buffer',
    },
    {
      '<leader>Z',
      function()
        Snacks.bufdelete.other()
      end,
      desc = 'Delete all buffers except the current',
    },
    {
      '<leader>gb',
      function()
        vim.ui.input({ prompt = 'Branch: ' }, function(branch)
          -- User pressed <Esc> (cancel input)
          if branch == nil then
            return
          end

          -- User pressed Enter without typing (empty string)
          if branch == '' then
            branch = nil
          end

          Snacks.gitbrowse({ branch = branch })
        end)
      end,
      mode = { 'n', 'v' },
      desc = 'Open GitHub link for current file or selection',
    },
  },
}
