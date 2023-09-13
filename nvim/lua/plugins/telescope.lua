local map = vim.keymap.set
local actions = require("telescope.actions")

local status, telescope = pcall(require, "telescope")
if not status then
	return
end

-- Plugin: telescope.nvim
--- https://github.com/nvim-telescope/telescope.nvim

telescope.setup({
	defaults = {
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		prompt_prefix = " 🔍  ",
		color_devicons = true,

		winblend = 0,

		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		file_ignore_patterns = { "node_modules", ".github/", ".git/" },

		layout_config = {
			width = 0.95,
			height = 0.85,

			horizontal = {
				preview_width = function(_, cols, _)
					if cols > 200 then
						return math.floor(cols * 0.4)
					else
						return math.floor(cols * 0.6)
					end
				end,
			},

			vertical = {
				width = 0.9,
				height = 0.95,
				preview_height = 0.5,
			},

			flex = {
				horizontal = {
					preview_width = 0.9,
				},
			},
		},

		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		mappings = {
			i = {
				["<C-x>"] = false,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<Esc>"] = actions.close,
			},
		},
	},
	-- overriding default settings
	pickers = {
		find_files = {
			-- theme = "dropdown",
			-- previewer = false,
			no_ignore = false,
			hidden = true,
		},
		buffers = {
			theme = "ivy",
			previewer = false,
		},
		live_grep = {
			prompt_title = "Grep Strings",
			results_title = false,
		},
	},
	extensions = {
		fzy_native = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

-- 🔭 Extensions --
-- https://github.com/nvim-telescope/telescope-file-browser.nvim
require("telescope").load_extension("file_browser")
require("telescope").load_extension("fzy_native")

-- Mappings
map("n", "<leader>tb", ":Telescope builtin<CR>")
map("n", "<leader>wd", ":Telescope diagnostics<CR>")
map("n", "<leader>ts", ":Telescope treesitter<CR>")

map("n", "<C-p>", ':lua require("telescope.builtin").find_files()<CR>')

map("n", "<leader>ps", ':lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep For > ")})<CR>')

-- Search string in loaded buffers
map(
	"n",
	"<leader>l",
	':lua require("telescope.builtin").live_grep({ prompt_title="< Buffers String >", grep_open_files=true })<CR>'
)

map("n", "<leader>?", ':lua require("telescope.builtin").oldfiles()<CR>')
map("n", "<leader>sb", ':lua require("telescope.builtin").buffers()<CR>')
map("n", "<leader>gb", ':lua require("telescope.builtin").git_branches()<CR>')
map("n", "<leader>rs", ':lua require("telescope.builtin").resume()<CR>')

-- Custom function should require from thuan.telescope instead
map("n", "<leader>sdf", ':lua require("thuan.telescope").search_dotfiles()<CR>')
map("n", "<leader>si", ':lua require("thuan.telescope").search_files_in_path()<CR>')
map("n", "<leader>li", ':lua require("thuan.telescope").live_grep_in_path()<CR>')

map("n", "<leader>sn", ':lua require("thuan.telescope").search_notes()<CR>')
map("n", "<leader>snf", ':lua require("thuan.telescope").search_note_files()<CR>')
map("n", "<leader>sr", ':lua require("thuan.telescope").search_references()<CR>')

map("n", "<leader>fb", ':lua require("thuan.telescope").file_explorer()<CR>')
