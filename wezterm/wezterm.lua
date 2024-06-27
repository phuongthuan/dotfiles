local wezterm = require("wezterm")

return {
	-- Config font
	font = wezterm.font("Mononoki Nerd Font Mono", { weight = "Bold" }),
	-- font = wezterm.font_with_fallback({
	-- 	"Mononoki Nerd Font Mono",
	-- 	"Fira Code",
	-- }),
	font_size = 12.0,
	-- font_rules = {
	-- 	{
	-- 		intensity = "Bold",
	-- 		font = wezterm.font("Mononoki Nerd Font Mono", { weight = "Bold" }),
	-- 	},
	-- 	{
	-- 		italic = true,
	-- 		font = wezterm.font("Mononoki Nerd Font Mono", { italic = true }),
	-- 	},
	-- 	{
	-- 		italic = true,
	-- 		intensity = "Bold",
	-- 		font = wezterm.font("Mononoki Nerd Font Mono", { weight = "Bold", italic = true }),
	-- 	},
	-- },

	color_scheme = "GruvboxDark",
	hide_tab_bar_if_only_one_tab = true,
	window_decorations = "RESIZE",
	enable_scroll_bar = false,

	-- Enable transparency
	window_background_opacity = 0.90,
}
