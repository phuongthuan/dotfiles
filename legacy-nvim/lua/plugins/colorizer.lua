local status, colorizer = pcall(require, "colorizer")
if not status then
	return
end

-- Plugin: nvim-colorizer
--- https://github.com/norcalli/nvim-colorizer

colorizer.setup({
	"css",
	"javascript",
	"html",
})
