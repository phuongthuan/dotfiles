-- Plugin: mattn/emmet-vim
--- https://github.com/mattn/emmet-vim

local g = vim.g

g.user_emmet_leader_key = ","
g.user_emmet_settings = {
	typescript = { extends = "jsx" },
	javascript = { extends = "jsx" },
}
