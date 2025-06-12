local nmap = require('core.utils').mapper_factory('n')

return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  config = function()
    local ufo = require('ufo')
    ufo.setup({
      -- treesitter not required
      -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
      -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`-
      provider_selector = function(_, _, _)
        return { 'treesitter', 'indent' }
      end,
      open_fold_hl_timeout = 0, -- Disable highlight timeout after opening
    })

    vim.o.foldenable = true
    vim.o.foldcolumn = '0' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99

    -- za to fold at cursor location is already enabled
    nmap('zR', ufo.openAllFolds, { desc = 'Open All Folds' })
    nmap('zM', ufo.closeAllFolds, { desc = 'Close All Folds' })
  end,
}
