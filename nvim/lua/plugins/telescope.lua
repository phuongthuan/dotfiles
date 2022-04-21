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

        layout_config = {
          horizontal = {
            mirror = false
          },
          vertical = {
            mirror = false
          }
        },

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
        prompt_title = 'Grep Strings',
        results_title = false,
      },
    },
    extensions = {
      fzy_native = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = false,
        override_file_sorter = true,
        case_mode = "smart_case", -- this is default
      }
    }
}

-- 🔭 Extensions --
-- https://github.com/nvim-telescope/telescope-file-browser.nvim
require('telescope').load_extension('file_browser')

require('telescope').load_extension('fzy_native')

-- Mappings
-- Telescope builtin function
map('n', '<leader>tb', ':Telescope builtin<CR>')
map('n', '<leader>wd', ':Telescope diagnostics<CR>')
map('n', '<leader>ts', ':Telescope treesitter<CR>')

map('n', '<C-p>', ':lua require("telescope.builtin").find_files()<CR>')

map('n', '<leader>ps', ':lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep For > ")})<CR>')

-- Search string in loaded buffers
map('n', '<leader>l', ':lua require("telescope.builtin").live_grep({ prompt_title="< Buffers String >", grep_open_files=true })<CR>')

map('n', '<leader>C', ':lua require("telescope.builtin").commands()<CR>')
map('n', '<leader>?', ':lua require("telescope.builtin").oldfiles()<CR>')
map('n', '<leader>sb', ':lua require("telescope.builtin").buffers()<CR>')
map('n', '<leader>gb', ':lua require("telescope.builtin").git_branches()<CR>')

-- Custom function should require from thuan.telescope instead
map('n', '<leader>sdf', ':lua require("thuan.telescope").search_dotfiles()<CR>')
map('n', '<leader>si', ':lua require("thuan.telescope").search_files_in_path()<CR>')
map('n', '<leader>li', ':lua require("thuan.telescope").live_grep_in_path()<CR>')

map('n', '<leader>sn', ':lua require("thuan.telescope").search_notes()<CR>')
map('n', '<leader>snf', ':lua require("thuan.telescope").search_note_files()<CR>')
map('n', '<leader>sr', ':lua require("thuan.telescope").search_references()<CR>')

map('n', '<leader>fb', ':lua require("thuan.telescope").file_explorer()<CR>')
