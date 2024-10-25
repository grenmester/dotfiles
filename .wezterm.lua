local wezterm = require("wezterm")

local value = "solarized"

local color_scheme_settings = {
	["solarized"] = {
		["cursor_bg"] = "#93A1A1",
		["color_scheme"] = "Solarized (dark) (terminal.sexy)",
	},
	["nord"] = {
		["cursor_bg"] = "#D8DEE9",
		["color_scheme"] = "nord",
	},
}

return {
	colors = {
		cursor_bg = color_scheme_settings[value].cursor_bg,
	},
	color_scheme = color_scheme_settings[value].color_scheme,
	enable_tab_bar = false,
	font = wezterm.font("FiraCode Nerd Font"),
}
