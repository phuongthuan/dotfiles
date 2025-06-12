vim.g.have_nerd_font = true

-- Skip providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this.o.on if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.o.timeoutlen = 300

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- General
vim.o.mouse = 'v' -- enable mouse middle click paste
vim.o.swapfile = false
vim.o.fileencoding = 'utf-8'
vim.o.scrolloff = 8
vim.o.cmdheight = 2
vim.o.conceallevel = 0 -- make `` is visible in markdown files
vim.o.showmode = false
vim.o.shortmess = 'c' -- don't show completion messages

-- UI
vim.o.syntax = 'enable' -- enable syntax highlighting
vim.o.number = false -- line number
-- vim.o.relativenumber = true -- relative line numbers, to help with jumping.
vim.o.showmatch = true -- highlight matching parenthesis

-- Folding (nvim-ufo.lua)
vim.o.foldenable = true -- Enable folding by default
vim.o.foldmethod = 'manual' -- Default fold method (change as needed)
vim.o.foldlevel = 99 -- Open most folds by default
vim.o.foldcolumn = '0'

vim.o.splitright = true -- vertical split to the right
vim.o.splitbelow = true -- horizontal split to the bottom
vim.o.ignorecase = true -- ignore case letters when search
vim.o.smartcase = true -- ignore lowercase for the whole pattern
vim.o.ruler = true -- show the cursor position all the time
vim.o.cursorline = true -- show which line your cursor is on
vim.o.hlsearch = true -- highlight search result
vim.o.termguicolors = true -- enable 24-bit RGB colors

-- Tabs, indent
vim.o.expandtab = true -- use spaces instead of tabs
vim.o.shiftwidth = 2 -- shift 2 spaces when tab
vim.o.tabstop = 2 -- 1 tab == 2 spaces
vim.o.smartindent = true -- autoindent new lines

-- Memory, CPU
vim.o.history = 100 -- remember n lines in history
-- vim.o.lazyredraw = true -- faster scrolling, disable for Noice
vim.o.synmaxcol = 240 -- max column for syntax highlight

-- Add asterisks in block comments
vim.opt.formatoptions:append({ 'r' })

-- Cursor highlighting
vim.api.nvim_set_hl(0, 'CursorN', { fg = '#fbf1c7', bg = '#fbf1c7' })
vim.api.nvim_set_hl(0, 'CursorI', { fg = '#fb4934', bg = '#fb4934' })
vim.opt.guicursor = {
  'n:block-CursorN',
  'i:block-CursorI',
  'r:block-CursorI',
  'v:block-CursorI',
  'ci:block-CursorI',
}

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true
