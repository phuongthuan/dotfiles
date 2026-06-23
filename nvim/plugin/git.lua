vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/NeogitOrg/neogit',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/phuongthuan/git-conflict.nvim',
})

local colors = require('utils').colors.gruvbox_dark
local nmap = require('utils').nmap
local vmap = require('utils').vmap
local mapper = require('utils').mapper

require('neogit').setup({
  disable_hint = true,
  commit_editor = {
    spell_check = false,
    show_staged_diff = false,
  },
  signs = {
    item = { '', '󰁌' },
    section = { '', '󰁌' },
  },
})

nmap('<leader>gg', '<cmd>Neogit kind=split_below_all<cr>', { desc = 'Neogit' })
nmap('<leader>gG', '<cmd>Neogit kind=split_below_all cwd=%:p:h<cr>', { desc = 'Neogit (buffer)' })
nmap('<leader>gc', '<cmd>NeogitCommit<cr>', { desc = 'Open Commit' })
nmap('<leader>gl', '<cmd>NeogitLogCurrent<cr>', { desc = 'Open Log (buffer)' })

vim.api.nvim_set_hl(0, 'GitConflictCurrent', { fg = colors.bright_fg, bg = '#1d3b40' })
vim.api.nvim_set_hl(0, 'GitConflictIncoming', { fg = colors.bright_fg, bg = '#1d3450' })

require('git-conflict').setup({
  disable_diagnostics = true,
  default_mappings = {
    next = 'nc',
    prev = 'pc',
  },
  highlights = {
    current = 'GitConflictCurrent',
    incoming = 'GitConflictIncoming',
  },
})

require('gitsigns').setup({
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
})
