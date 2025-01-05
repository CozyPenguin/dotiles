local wt = require("wezterm")

return {
	-- Linux
	enable_wayland = true,
	xcursor_theme = "Adwaita",
	-- Font configuration
	font = wt.font("FiraCode Nerd Font"),
	font_size = 12,
	-- Theming
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,

	-- use Zellij
	default_prog = { "zellij" },
}
