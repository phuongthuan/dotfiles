local mapper = require('core.utils').mapper_factory
local nmap = mapper('n')
local vmap = mapper('v')

return {
  {
    'tpope/vim-fugitive',
    keys = {
      {
        '<leader>g',
        '<cmd>G<cr>',
        desc = 'Open Git',
        silent = true,
      },
      {
        '<leader>gl',
        '<cmd>GV<cr>',
        desc = 'Open Git Commits',
        silent = true,
      },
      {
        '<leader>L',
        function()
          vim.cmd('GV ' .. vim.fn.expand('%:p'))
        end,
        desc = 'Git Commits On Current File',
        silent = true,
      },
      { '<leader>P', '<cmd>G push origin HEAD --no-verify<cr>', desc = 'Git Push without verify', silent = true },
      { '<leader>gc', '<cmd>Gvdiffsplit!<cr>', desc = 'Git Resolve Conflict', silent = true },
    },
  },
  'junegunn/gv.vim', -- Display Git commits list
  'tpope/vim-rhubarb', -- For :GBrowse usages
  {
    'lewis6991/gitsigns.nvim',
    opts = {
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
        end)

        nmap('<leader>hd', gitsigns.diffthis)

        nmap('<leader>hD', function()
          gitsigns.diffthis('~')
        end)

        mapper({ 'o', 'x' })('ih', gitsigns.select_hunk, { desc = 'Select Hunk' })
      end,
    },
  },
  {
    'ThePrimeagen/git-worktree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('git-worktree').setup()
      require('telescope').load_extension('git_worktree')
    end,
    keys = {
      -- HACK: by default
      -- <Enter> - switches to that worktree
      -- <c-d> - deletes that worktree
      -- <c-f> - toggles forcing of the next deletion
      {
        '<leader>wl',
        function()
          require('telescope').extensions.git_worktree.git_worktrees()
        end,
        { desc = 'Git Worktree List' },
      },
      {
        '<leader>wc',
        function()
          require('telescope').extensions.git_worktree.create_git_worktree()
        end,
        { desc = 'Create Git Worktree Branches' },
      },
    },
  },
}

-- Fugitive keymaps
-- nmap('<leader>g', ':G<cr>')
-- nmap('<leader>gl', ':GV<cr>')
-- nmap('<leader>gL', ":GV <C-R>=expand('%:p')<cr><cr>")
-- nmap('<leader>gp', ':G push origin HEAD<cr>')
-- nmap('<leader>P', ':G push origin HEAD --no-verify<cr>')
-- nmap('<leader>gP', ':G push origin HEAD -f<cr>')
-- nmap('<leader>gM', ':G push origin master<cr>')
-- nmap('<leader>gm', ':G merge<Space>')
-- nmap('<leader>gp', ':G push origin HEAD<cr>')
-- nmap('<leader>P', ':G push origin HEAD --no-verify<cr>')
-- nmap('<leader>gP', ':G push origin HEAD -f<cr>')
-- nmap('<leader>gM', ':G push origin master<cr>')
-- nmap('<leader>gm', ':G merge<Space>')

-- Resolve conflict
-- nmap('<leader>grc', ':Gvdiffsplit!<cr>')
-- nmap('<leader>op', ':!oprl atsmobile<CR>')

-- Gvdiffsplit mode
-- d2o : get the left column
-- d3o : get the right column
