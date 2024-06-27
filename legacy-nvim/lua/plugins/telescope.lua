local map = vim.keymap.set

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local custom = require("thuan.telescope")

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

		file_ignore_patterns = { "node_modules", ".git/" },

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
			previewer = false,
			-- no_ignore = false,
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

map("n", "<C-p>", builtin.find_files)
map("n", "<leader>pf", builtin.git_files)

map("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

--- Search string in open buffers
map("n", "<leader>l", function()
	builtin.live_grep({ prompt_title = "< Search string in open buffers >", grep_open_files = true })
end)

map("n", "<leader>?", builtin.oldfiles)
map("n", "<leader>sb", builtin.buffers)
map("n", "<leader>gb", builtin.git_branches)
map("n", "<leader>rs", builtin.resume)

-- Custom functions
map("n", "<leader>sdf", custom.search_dotfiles)
map("n", "<leader>si", custom.search_files_in_path)
map("n", "<leader>li", custom.live_grep_in_path)
map("n", "<leader>P", custom.live_grep_all)

map("n", "<leader>sn", custom.search_notes)
map("n", "<leader>snf", custom.search_note_files)
map("n", "<leader>sr", custom.search_references)

map("n", "<leader>fb", custom.file_explorer)
