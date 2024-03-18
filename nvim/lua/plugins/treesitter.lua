-- Plugin: nvim-treesitter
--- https://github.com/nvim-treesitter/nvim-treesitter

local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

ts.setup({
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	endwise = {
		enable = true,
	},
	ensure_installed = {
    "vimdoc",
		"javascript",
		"typescript",
		"tsx",
		"lua",
		"json",
		"yaml",
		"css",
		"scss",
		"ruby",
		"html",
		"graphql",
		"go",
		"gomod",
	},
	autotag = {
		enable = true,
	},
	autopairs = {
		enable = true,
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
