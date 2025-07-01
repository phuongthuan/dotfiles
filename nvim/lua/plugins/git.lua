local mapper = require('core.utils').mapper_factory
local nmap = mapper('n')
local vmap = mapper('v')

vim.api.nvim_create_autocmd('User', {
  pattern = 'GitConflictDetected',
  callback = function()
    vim.notify('Conflict detected in ' .. vim.fn.expand('<afile>'))
    vim.keymap.set('n', 'cww', function()
      ---@diagnostic disable-next-line: undefined-global
      engage.conflict_buster()
      ---@diagnostic disable-next-line: undefined-global
      create_buffer_local_mappings()
    end)
  end,
})

nmap('<leader>gr', '<cmd>GitConflictListQf<cr>', { desc = 'Resolve Conflict' })

return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'echasnovski/mini.pick',
    },
    command = { 'Neogit', 'NeogitCommit', 'NeogitLogCurrent', 'NeogitResetState' },
    opts = {
      disable_hint = true,
      commit_editor = {
        spell_check = false,
        show_staged_diff = false,
      },
      signs = {
        item = { '', '󰁌' },
        section = { '', '󰁌' },
      },
    },
    keys = {
      {
        '<leader>gg',
        '<cmd>Neogit<cr>',
        desc = 'Neogit',
        silent = true,
      },
      {
        '<leader>gG',
        '<cmd>Neogit cwd=%:p:h<cr>',
        desc = 'Neogit (buffer)',
        silent = true,
      },
      {
        '<leader>gc',
        '<cmd>NeogitCommit<cr>',
        desc = 'Open Commit',
        silent = true,
      },
      {
        '<leader>gL',
        '<cmd>NeogitLogCurrent<cr>',
        desc = 'Open Log (buffer)',
        silent = true,
      },
      {
        '<leader>grs',
        '<cmd>NeogitResetState<cr>',
        desc = 'Reset State',
        silent = true,
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      current_line_blame = true,
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        -- Navigation
        nmap(']c', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end, { buffer = bufnr, desc = 'Next Hunk' })

        nmap('[c', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end, { buffer = bufnr, desc = 'Previous Hunk' })

        -- Actions
        nmap('<leader>hs', gitsigns.stage_hunk, { desc = 'Stage Hunk' })
        nmap('<leader>hr', gitsigns.reset_hunk, { desc = 'Reset Hunk' })

        vmap('<leader>hs', function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)
        vmap('<leader>hr', function()
          gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)

        nmap('<leader>hS', gitsigns.stage_buffer, { desc = 'Stage Buffer' })
        nmap('<leader>hR', gitsigns.reset_buffer, { desc = 'Reset Buffer' })
        nmap('<leader>pv', gitsigns.preview_hunk_inline, { desc = 'Preview Hunk Inline' })

        nmap('<leader>hb', function()
          gitsigns.blame_line({ full = true })
        end, { desc = 'Toggle Blame Line' })

        nmap('<leader>hd', gitsigns.diffthis, { desc = 'Diff This' })

        nmap('<leader>hD', function()
          gitsigns.diffthis('~')
        end, { desc = 'Diff This (~)' })

        mapper({ 'o', 'x' })('ih', gitsigns.select_hunk, { desc = 'Select Hunk' })
      end,
    },
  },
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    opts = {},
  },
}
