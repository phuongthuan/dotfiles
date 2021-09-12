-----------------------------------------------------------
-- Telescope
-----------------------------------------------------------

-- Plugin: telescope.nvim
--- https://github.com/nvim-telescope/telescope.nvim

local actions = require('telescope.actions')
local cmd = vim.cmd

require('telescope').setup{
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = ' 🔍 ',
    color_devicons = true,

    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    mappings = {
      i = {
        ['<C-x>'] = false,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-q>'] = actions.send_to_qflist,
        ['<Esc>'] = actions.close,
      }
    }
  },
  -- overriding default settings
  pickers = {
    find_files = {
      theme = 'dropdown'
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
}

require('telescope').load_extension('fzy_native')

-- Mappings
cmd [[
  nnoremap <C-p> :lua require('telescope.builtin').find_files()<CR>
  nnoremap <leader>ps :lua require('telescope.builtin').live_grep()<CR>
  nnoremap <leader>gg :lua require('telescope.builtin').git_status()<CR>
  nnoremap <leader>ht :lua require('telescope.builtin').help_tags()<CR>
  nnoremap <leader>C :lua require('telescope.builtin').commands()<CR>
  nnoremap <leader>h :lua require('telescope.builtin').oldfiles()<CR>
  nnoremap <leader>bb :lua require('telescope.builtin').buffers()<CR>
  nnoremap <leader>gb :lua require('thuan.telescope').git_branches()<CR>
  nnoremap <leader>vrc :lua require('thuan.telescope').search_dotfiles()<CR>
]]
