vim.g.have_nerd_font = true

-- Skip providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

-- Make line numbers default
vim.opt.number = true

-- Relative line numbers, to help with jumping.
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- General
vim.opt.mouse = 'v' -- enable mouse middle click paste
vim.opt.swapfile = false -- don't use swapfile
vim.opt.fileencoding = 'utf-8' -- the encoding written to file
vim.opt.scrolloff = 8
vim.opt.cmdheight = 2
vim.opt.conceallevel = 0 -- make `` is visible in markdown files
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.completeopt = 'menuone,noselect,noinsert' -- completion options
vim.opt.shortmess = 'c' -- don't show completion messages

-- UI
vim.opt.syntax = 'enable' -- enable syntax highlighting
vim.opt.number = true -- show line number
vim.opt.showmatch = true -- highlight matching parenthesis

-- Folding (nvim-ufo)
vim.o.foldenable = true -- Enable folding by default
vim.o.foldmethod = 'manual' -- Default fold method (change as needed)
vim.o.foldlevel = 99 -- Open most folds by default
vim.o.foldcolumn = '0'

vim.opt.colorcolumn = '' -- line lenght marker at 80 columns, "" mean hide it
vim.opt.splitright = true -- vertical split to the right
vim.opt.splitbelow = true -- horizontal split to the bottom
vim.opt.ignorecase = true -- ignore case letters when search
vim.opt.smartcase = true -- ignore lowercase for the whole pattern
vim.opt.ruler = true -- show the cursor position all the time
vim.opt.cursorline = true -- show which line your cursor is on
vim.opt.hlsearch = true -- highlight search result
vim.opt.termguicolors = true -- enable 24-bit RGB colors

-- Tabs, indent
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.shiftwidth = 2 -- shift 2 spaces when tab
vim.opt.tabstop = 2 -- 1 tab == 2 spaces
vim.opt.smartindent = true -- autoindent new lines

-- Memory, CPU
vim.opt.history = 100 -- remember n lines in history
vim.opt.lazyredraw = true -- faster scrolling
vim.opt.synmaxcol = 240 -- max column for syntax highlight

-- Add asterisks in block comments
vim.opt.formatoptions:append({ 'r' })

-- Cursor highlighting
vim.cmd([[
  hi CursorN guifg=#fbf1c7 guibg=#fbf1c7
  hi CursorI guifg=#fb4934 guibg=#fb4934
  set guicursor=n:block-CursorN,i-r-v-ci:block-CursorI
]])
