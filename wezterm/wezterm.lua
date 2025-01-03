local wt = require("wezterm")

return {
	-- Linux
	enable_wayland = false,
	front_end = "WebGpu",
	-- Font configuration
	font = wt.font("Fira Code"),
	font_size = 12,
	-- Theming
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,

	-- use Zellij
	default_prog = { "zellij" },
}
