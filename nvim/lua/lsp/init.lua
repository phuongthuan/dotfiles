-- Before upgrade to newer Neovim, please check :h deprecated

local tsserver = require("lsp/tsserver")
local solargraph = require("lsp/solargraph")

local map = vim.keymap.set

--- For language server setup see: https://github.com/neovim/nvim-lspconfig
-- plugin: nvim-lspconfig

vim.diagnostic.config({
	underline = true,
	virtual_text = false,
	severity_sort = true,
	update_in_insert = false,
})

local opts = { noremap = true, silent = true }
map("n", "]e", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
map("n", "[e", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
map("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opts)

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", bufopts)
	map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
	map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", bufopts)
	map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)
	map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
	map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", bufopts)
	map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", bufopts)

	map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
	map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", bufopts)

	if client.name == "solargraph" or client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

tsserver.setup(on_attach, capabilities)

solargraph.setup(on_attach, capabilities)

require("lsp.html")

require("lsp.graphql")

require("lsp.null-ls")
