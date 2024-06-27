local map = vim.keymap.set

-- Plugin: vim-fugitive
--- https://github.com/tpope/vim-fugitive

-- Status/Log
map("n", "<leader>g", ":G<CR>")
map("n", "<leader>gl", ":GV<CR>")
map("n", "<leader>gL", ":GV <C-R>=expand('%:p')<CR><CR>")

-- Branch
map("n", "<leader>go", ":G checkout<Space>")
map("n", "<leader>gom", ":G checkout master<CR>")
map("n", "<leader>gd", ":G diff<CR>")

-- Push/Pull
map("n", "<leader>gp", ":G push origin HEAD<CR>")
map("n", "<leader>gP", ":G push origin HEAD -f<CR>")
map("n", "<leader>gM", ":G push origin master<CR>")

-- Merge/Rebase
map("n", "<leader>gm", ":G merge<Space>")
map("n", "<leader>gr", ":G rebase<Space>")

-- Resolve conflict
map("n", "<leader>rc", ":Gvdiffsplit!<CR>")

-- on the Gvdiffsplit mode
-- d2o : get the left column
-- d3o : get the right column
