-- Define colors
local colors = {
	background = "#282c34",
	foreground = "#abb2bf",
	accent = "#61afef",
	urgent = "#e06c75",
	border_normal = "#3f444a",
	border_focus = "#61afef",
}

-- Define fonts
local fonts = {
	primary = "sans 10",
	secondary = "monospace 9",
}

-- Create a theme object
local theme = {}

theme.font = fonts.primary
theme.bg_normal = colors.background
theme.fg_normal = colors.foreground
theme.bg_focus = colors.accent
theme.fg_focus = colors.background
theme.bg_urgent = colors.urgent
theme.fg_urgent = colors.background
theme.border_width = 2
theme.border_normal = colors.border_normal
theme.border_focus = colors.border_focus

-- Define wallpaper
theme.wallpaper = "/home/matt/wallpapers/eva.jpg"

-- Add more theme elements as needed

return theme
