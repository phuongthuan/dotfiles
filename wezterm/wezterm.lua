local wezterm = require("wezterm")

return {
	-- Config font
	font = wezterm.font("Dank Mono", { weight = "Medium" }),
	font_size = 13.5,

	color_scheme = "GruvboxDark",
	-- color_scheme = "Gruvbox light, soft (base16)",
	hide_tab_bar_if_only_one_tab = true,
	window_decorations = "RESIZE",
	enable_scroll_bar = false,

	-- Enable transparency
	window_background_opacity = 0.90,
}
