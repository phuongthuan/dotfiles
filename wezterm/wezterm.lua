local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Enable transparency
config.window_background_opacity = 0.95

-- Font configuration
-- config.font = wezterm.font("Dank Mono", { weight = "Regular" })
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" })
config.font_size = 13.5

-- Remove all padding
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- F11 to toggle fullscreen mode
config.keys = {
	{ key = "n", mods = "SHIFT|CTRL", action = wezterm.action.ToggleFullScreen },
}

-- Color scheme configuration
config.color_scheme = "GruvboxDark"

config.hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = false

-- Use zsh by default
-- config.default_prog = { "/usr/bin/zsh" }

-- Don't hide cursor when typing
config.hide_mouse_cursor_when_typing = false

-- Remove the title bar from the window
config.window_decorations = "RESIZE"

-- URLs in Markdown files are not handled properly by default
-- Source: https://github.com/wez/wezterm/issues/3803#issuecomment-1608954312
config.hyperlink_rules = {
	-- Matches: a URL in parens: (URL)
	{
		regex = "\\((\\w+://\\S+)\\)",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in brackets: [URL]
	{
		regex = "\\[(\\w+://\\S+)\\]",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in curly braces: {URL}
	{
		regex = "\\{(\\w+://\\S+)\\}",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in angle brackets: <URL>
	{
		regex = "<(\\w+://\\S+)>",
		format = "$1",
		highlight = 1,
	},
	-- Then handle URLs not wrapped in brackets
	{
		-- Before
		--regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
		--format = '$0',
		-- After
		regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
		format = "$1",
		highlight = 1,
	},
	-- implicit mailto link
	{
		regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
		format = "mailto:$0",
	},
}

-- Return the configuration to wezterm
return config
