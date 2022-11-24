local gitsigns = require('gitsigns')

-- Plugin: gitsigns.nvim
--- https://github.com/lewis6991/gitsigns.nvim

gitsigns.setup {
    signs = {
        add = {hl = 'GitSignsAdd', text = '▋', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn'},
        change = {hl = 'GitSignsChange', text = '▋', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
        delete = {hl = 'GitSignsDelete', text = '▸', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
        topdelete = {hl = 'GitSignsDelete', text = '▾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '▋', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'}
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`

    watch_gitdir = {interval = 1000, follow_files = true},

    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000
    },

    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- jumping
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return '<Ignore>'
        end, {expr = true})

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return '<Ignore>'
        end, {expr = true})

        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hR', gs.reset_buffer)

        -- preview
        map('n', '<leader>pv', ':Gitsigns preview_hunk<CR>')
        map('n', '<leader>hb', function()
            gs.blame_line {full = true}
        end)

        -- stage and reset
        map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
        map({'n', 'v'}, '<leader>R', ':Gitsigns reset_hunk<CR>')
    end
}
