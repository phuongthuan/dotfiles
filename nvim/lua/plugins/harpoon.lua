local map = vim.keymap.set

local status, harpoon = pcall(require, "harpoon")
if not status then
	return
end

-- Plugin: harpoon
--- https://github.com/ThePrimeagen/harpoon

harpoon.setup({
	menu = {
		width = 100,
	},
})

-- Keymaps
map("n", "<C-a>", ':lua require("harpoon.mark").add_file()<CR>:echo "Added to harpoon !!"<CR>')
map("n", "<C-e>", ':lua require("harpoon.ui").toggle_quick_menu()<CR>')

map("n", "<leader>1", ':lua require("harpoon.ui").nav_file(1)<CR>')
map("n", "<leader>2", ':lua require("harpoon.ui").nav_file(2)<CR>')
map("n", "<leader>3", ':lua require("harpoon.ui").nav_file(3)<CR>')
map("n", "<leader>4", ':lua require("harpoon.ui").nav_file(4)<CR>')
map("n", "<leader>5", ':lua require("harpoon.ui").nav_file(5)<CR>')

map("n", "<leader>t", ':lua require("harpoon.term").gotoTerminal(1)<CR>')
