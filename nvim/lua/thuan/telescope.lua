local builtin = require("telescope.builtin")
local variable = require("thuan.variable")

local M = {}

-- Short key: <leader>sdf
M.search_dotfiles = function()
	builtin.find_files({
		prompt_title = " Dotfiles",
		cwd = variable.dotfiles_path,
		-- hidden = true,
	})
end

-- Short key: <leader>sr
M.search_references = function()
	builtin.find_files({
		prompt_title = " References",
		cwd = variable.references_path,
		hidden = true,
	})
end

-- Short key: <leader>sn
M.search_notes = function()
	builtin.live_grep({
		prompt_title = " Grep Notes",
		prompt_prefix = " ﮷ ",
		cwd = variable.icloud_drive_obsidian_path,
		layout_config = { preview_width = 0.45, width = 0.9 },
		hidden = true,
	})
end

-- Short key: <leader>snf
M.search_note_files = function()
	builtin.find_files({
		prompt_title = " Find Notes",
		prompt_prefix = " ﮷ ",
		cwd = variable.icloud_drive_obsidian_path,
		hidden = true,
	})
end

-- Short key: <leader>si
M.search_files_in_path = function(path)
	local _path = path or vim.fn.input("Directory: > ", "", "dir")
	builtin.find_files({
		search_dirs = { _path },
		prompt_title = " Files",
	})
end

-- Short key: <leader>li
M.live_grep_in_path = function(path)
	local _path = path or vim.fn.input("Directory: > ", "", "dir")
	builtin.live_grep({
		search_dirs = { _path },
		prompt_title = " Grep Strings",
	})
end

-- Short key: <leader>P
M.live_grep_all = function()
	builtin.live_grep({
		prompt_title = " Search exact strings",
		layout_config = { vertical = { width = 0.65 } },
	})
end

M.file_explorer = function()
	require("telescope").extensions.file_browser.file_browser({
		prompt_title = " File Browser",
		path_display = { "smart" },
		cwd = "~",
	})
end

return M
