-----------------------------------------------------------
-- Telescope
-----------------------------------------------------------

local actions = require('telescope.actions')
local map = require('utils').map

-- Plugin: telescope.nvim
--- https://github.com/nvim-telescope/telescope.nvim

require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = ' 🔍  ',
        color_devicons = true,

        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

        file_ignore_patterns = {'node_modules', '.git'},

        layout_config = {horizontal = {mirror = false}, vertical = {mirror = false}},
        vimgrep_arguments = {'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
        mappings = {
            i = {
                ['<C-x>'] = false,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<Esc>'] = actions.close
            }
        }
    },
    -- overriding default settings
    pickers = {
      find_files = {theme = 'dropdown', previewer = false},
      buffers = {
        theme = 'ivy',
        previewer = false,
      },
      live_grep = {
        prompt_title = 'Search Strings',
        results_title = false,
      },
    },
    extensions = {fzy_native = {override_generic_sorter = false, override_file_sorter = true}}
}

require('telescope').load_extension('fzy_native')

-- Mappings

-- Telescope builtin function
map('n', '<leader>tb', ':Telescope builtin<CR>')

map('n', '<C-p>', ':lua require("telescope.builtin").find_files()<CR>')
map('n', '<leader>ps', ':lua require("telescope.builtin").live_grep()<CR>')
map('n', '<leader>pw', ':lua require("telescope.builtin").grep_string()<CR>')

map('n', '<leader>C', ':lua require("telescope.builtin").commands()<CR>')
map('n', '<leader>?', ':lua require("telescope.builtin").oldfiles()<CR>')
map('n', '<leader>sb', ':lua require("telescope.builtin").buffers()<CR>')
map('n', '<leader>sfb', ':lua require("telescope.builtin").file_browser()<CR>')

-- Git
map('n', '<leader>gg', ':lua require("telescope.builtin").git_status()<CR>')
map('n', '<leader>gc', ':lua require("telescope.builtin").git_commits()<CR>')
map('n', '<leader>gb', ':lua require("telescope.builtin").git_branches()<CR>')

-- Custom function should require from thuan.telescope instead
map('n', '<leader>sdf', ':lua require("thuan.telescope").search_dotfiles()<CR>')
map('n', '<leader>sn', ':lua require("thuan.telescope").search_notes()<CR>')
map('n', '<leader>snf', ':lua require("thuan.telescope").search_note_files()<CR>')
map('n', '<leader>sr', ':lua require("thuan.telescope").search_references()<CR>')

