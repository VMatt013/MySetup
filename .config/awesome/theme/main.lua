local theme = {}

theme.colors = {
	main = "#811d5888",
	text = "#ffffff",
	secondary = "#000000",
	bg = "#ff888099",
	border = "#000000",
}
theme.bar = {
	border_width = 3,
	border_color = theme.colors.border,
	position = "top",
	height = 25,
	margins = {
		top = 5,
		bottom = 5,
		left = 10,
		right = 10,
	},
	opacity = 1,
	bg = theme.colors.main,
	fg = theme.colors.text,
}

theme.titlebar = {
	size = 25,
	bg_normal = theme.colors.main,
	bg_focus = theme.colors.main,
	h_margin = 15,
	v_margin = 1,
}

theme.client = {
	border_width = 3,
	border_color = theme.colors.border,
}

theme.dpi = 20

theme.wallpapers = { "/home/matt/wallpapers/eclipse.jpg", "/home/matt/wallpapers/eva.jpg" }
return theme
