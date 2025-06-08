local mapper = require('core.utils').mapper_factory
local nmap = mapper('n')

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
    },
  },
  'junegunn/gv.vim', -- Display Git commits list
  'tpope/vim-rhubarb', -- For :GBrowse usages
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      signcolumn = true,
      current_line_blame = true,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        nmap(']c', gs.next_hunk, { buffer = bufnr, desc = 'Next Hunk' })
        nmap('[c', gs.prev_hunk, { buffer = bufnr, desc = 'Prev Hunk' })

        mapper({ 'n', 'v' })('<leader>hs', ':Gitsigns stage_hunk<CR>', { buffer = bufnr, desc = 'Stage Hunk' })
        mapper({ 'n', 'v' })('<leader>hr', ':Gitsigns reset_hunk<CR>', { buffer = bufnr, desc = 'Reset Hunk' })

        nmap('<leader>hS', gs.stage_buffer, { buffer = bufnr, desc = 'Stage Buffer' })
        nmap('<leader>hu', gs.undo_stage_hunk, { buffer = bufnr, desc = 'Undo Stage Hunk' })

        nmap('<leader>pv', gs.preview_hunk_inline, { buffer = bufnr, desc = 'Preview Hunk Inline' })

        nmap('<leader>hb', function()
          gs.blame_line({ full = true })
        end, { buffer = bufnr, desc = 'Blame Line' })

        nmap('<leader>hd', gs.diffthis, { buffer = bufnr, desc = 'Diff This' })
      end,
    },
  },
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      {
        '<leader>U',
        '<cmd>UndotreeToggle<cr>',
        desc = 'Toggle Undo Tree',
      },
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
