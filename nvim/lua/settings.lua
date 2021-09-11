-----------------------------------------------------------
-- Neovim settings
-- General Neovim settings
-----------------------------------------------------------
-----------------------------------------------------------
-- API aliases
-----------------------------------------------------------
-- local map = vim.api.nvim_set_keymap  -- set global keymap
local cmd = vim.cmd -- execute Vim commands
local exec = vim.api.nvim_exec -- execute Vimscript
-- local fn = vim.fn -- call Vim functions
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options

-----------------------------------------------------------
-- General
-----------------------------------------------------------
g.mapleader = ' ' -- change leader to a comma
opt.mouse = 'a' -- enable mouse support
opt.mouse = 'v' -- enable mouse middle click paste
opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
opt.swapfile = false -- don't use swapfile
opt.encoding = 'utf-8' -- the encoding displayed
opt.fileencoding = 'utf-8' -- the encoding written to file

cmd [[
  set nocompatible
  filetype plugin on
  filetype indent on
]]

-----------------------------------------------------------
-- UI
-----------------------------------------------------------
opt.syntax = 'enable' -- enable syntax highlighting
opt.number = true -- show line number
opt.showmatch = true -- highlight matching parenthesis
opt.foldmethod = 'marker' -- enable folding (default 'foldmarker')
opt.colorcolumn = '80' -- line lenght marker at 80 columns
opt.splitright = true -- vertical split to the right
opt.splitbelow = true -- orizontal split to the bottom
opt.ignorecase = true -- ignore case letters when search
opt.smartcase = true -- ignore lowercase for the whole pattern
opt.ruler = true -- show the cursor position all the time
opt.cursorline = true -- Enable cursorline all time
opt.hlsearch = true -- highlight search result
-- opt.noshowmode = true         -- we don't need to see thing like -- INSERT --

-- remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]

-- highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true -- enable background buffers
opt.history = 100 -- remember n lines in history
opt.lazyredraw = true -- faster scrolling
opt.synmaxcol = 240 -- max column for syntax highlight

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
opt.termguicolors = true -- enable 24-bit RGB colors
opt.background = 'dark'
cmd [[colorscheme gruvbox]] -- set colorscheme
cmd [[highlight Normal ctermbg=None]]

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 2 -- shift 2 spaces when tab
opt.tabstop = 2 -- 1 tab == 2 spaces
opt.smartindent = true -- autoindent new lines

-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- remove line lenght marker for selected filetypes
cmd [[autocmd FileType text,markdown,xml,html,xhtml,javascript setlocal cc=0]]

-- 2 spaces for selected filetypes
cmd [[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
]]

-- IndentLine
-- g.indentLine_setColors = 0  -- set indentLine color
g.indentLine_char = '┊' -- set indentLine character

-- disable IndentLine for markdown files (avoid concealing)
cmd [[autocmd FileType markdown let g:indentLine_enabled=0]]

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------
opt.completeopt = 'menuone,noselect,noinsert' -- completion options
opt.shortmess = 'c' -- don't show completion messages

-- auto format Lua
-- cmd[[
--   autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)
-- ]]

-- auto format
cmd [[
  autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 1000)
  autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 1000)
  autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 1000)
]]
