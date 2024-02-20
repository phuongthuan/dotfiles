local g = vim.g
local cmd = vim.cmd
local exec = vim.api.nvim_exec
local opt = vim.opt

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

cmd([[
  set nocompatible
  filetype plugin on
  filetype indent on
]])

-- UI
opt.syntax = "enable" -- enable syntax highlighting
opt.number = true -- show line number
opt.showmatch = true -- highlight matching parenthesis
-- opt.foldmethod = "marker" -- enable folding (default 'foldmarker')
opt.colorcolumn = "80" -- line lenght marker at 80 columns
opt.splitright = true -- vertical split to the right
opt.splitbelow = true -- horizontal split to the bottom
opt.ignorecase = true -- ignore case letters when search
opt.smartcase = true -- ignore lowercase for the whole pattern
opt.ruler = true -- show the cursor position all the time
opt.cursorline = true -- Enable cursorline all time
opt.hlsearch = true -- highlight search result
opt.termguicolors = true -- enable 24-bit RGB colors
opt.relativenumber = false

-- highlight on yank
exec(
	[[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]],
	false
)

-- Memory, CPU
opt.history = 100 -- remember n lines in history
opt.lazyredraw = true -- faster scrolling
opt.synmaxcol = 240 -- max column for syntax highlight

-- Colorscheme
cmd([[ highlight Normal ctermbg=None ]])

-- Cursor
cmd([[
  hi Cursor2 guifg=#fe8019 guibg=#fe8019
  set guicursor=i-r-v-ci:block-Cursor2
]])

-- Highlight error
-- cmd([[ autocmd ColorScheme * :lua require('vim.lsp.diagnostic')._define_default_signs_and_highlights() ]])
cmd([[ autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE ]])

-- Tabs, indent
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 2 -- shift 2 spaces when tab
opt.tabstop = 2 -- 1 tab == 2 spaces
opt.smartindent = true -- autoindent new lines

cmd([[au BufEnter * set fo-=c fo-=r fo-=o]]) -- don't auto commenting new lines

cmd([[autocmd BufWritePre * :%s/\s\+$//e]]) -- remove all trailing space when saving file

-- remove line length marker for selected filetypes
cmd([[autocmd FileType text,markdown,xml,html,xhtml,javascript setlocal cc=0]])

-- 2 spaces for selected filetypes
cmd([[ autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2 ]])

-- IndentLine
-- g.indentLine_enabled = 0
-- g.indentLine_setColors = 0
-- g.indentLine_char_list = { '|', '¦', '┆', '┊', '·' }
g.indentLine_char = "·"

-- Disable netrw
-- g.loaded_netrw = 1
-- g.loaded_netrwPlugin = 1

-- Disable IndentLine for markdown files (avoid concealing)
cmd([[autocmd FileType markdown let g:indentLine_enabled=0]])

-- nvim context commentstring
g.skip_ts_context_commentstring_module = true
