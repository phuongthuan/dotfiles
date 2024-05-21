local opt = vim.opt

-- Override LazyVim config
vim.g.mapleader = " "
vim.g.lazygit_theme = false
-- vim.g.autoformat = false

-- General
opt.mouse = "a" -- enable mouse support
opt.mouse = "v" -- enable mouse middle click paste
opt.clipboard = "unnamedplus" -- copy/paste to system clipboard
opt.swapfile = false -- don't use swapfile
opt.fileencoding = "utf-8" -- the encoding written to file
opt.scrolloff = 8
opt.cmdheight = 2
opt.conceallevel = 0 -- make `` is visible in markdown files
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.completeopt = "menuone,noselect,noinsert" -- completion options
opt.shortmess = "c" -- don't show completion messages

-- UI
opt.syntax = "enable" -- enable syntax highlighting
opt.number = true -- show line number
opt.showmatch = true -- highlight matching parenthesis
opt.foldmethod = "marker" -- enable folding (default 'foldmarker')
opt.colorcolumn = "" -- line lenght marker at 80 columns, "" mean hide it
opt.splitright = true -- vertical split to the right
opt.splitbelow = true -- horizontal split to the bottom
opt.ignorecase = true -- ignore case letters when search
opt.smartcase = true -- ignore lowercase for the whole pattern
opt.ruler = true -- show the cursor position all the time
opt.cursorline = true -- Enable cursorline all time
opt.hlsearch = true -- highlight search result
opt.termguicolors = true -- enable 24-bit RGB colors
opt.relativenumber = false -- disable relativenumber

-- Tabs, indent
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 2 -- shift 2 spaces when tab
opt.tabstop = 2 -- 1 tab == 2 spaces
opt.smartindent = true -- autoindent new lines

-- Memory, CPU
opt.history = 100 -- remember n lines in history
opt.lazyredraw = true -- faster scrolling
opt.synmaxcol = 240 -- max column for syntax highlight

-- Add asterisks in block comments
opt.formatoptions:append({ "r" })

vim.cmd([[
  hi Cursor2 guifg=#fe8019 guibg=#fe8019
  set guicursor=i-r-v-ci:block-Cursor2
]])
