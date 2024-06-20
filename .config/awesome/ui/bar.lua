local Debug = require("Debug")
local awful = require("awful")
local wibox = require("wibox")
local theme = require("theme.bar-test")

---------------------
-- Widgets------------
---------------------
local beautiful = require("beautiful")
local promptbox = require("widgets.promptbox")
local clock = wibox.widget.textclock()
local battery_widget = require("widgets.battery-status.battery")
local logout_menu = require("widgets.logout-menu.logout-menu")
local volume_widget = require("widgets.pactl.volume")
local spotify_widget = require("widgets.spotify")
local my_systray = wibox.widget.systray()
local margin = require("widgets.margin")
local test = require("widgets.testwidget")

awful.screen.connect_for_each_screen(function(s)
	awful.tag({ "1", "2", "3" }, s, awful.layout.layouts[1])

	s.tasklist = require("widgets.tasklist")(s, 300)
	s.taglist = require("widgets.taglist")(s)
	s.promptbox = promptbox

	s.bar = awful.wibar({
		border_width = theme.bar.border_width,
		border_color = theme.bar.border_color,
		position = theme.bar.position,
		height = theme.bar.height,
		margins = theme.bar.margins,
		fg = theme.bar.fg,
		bg = theme.bar.bg,
		shape = theme.bar.shape,
		screen = s,
		top = 10,
		visible = true,
	})

	if s == screen.primary then
		s.bar:setup({
			layout = wibox.layout.align.horizontal,
			expand = "none",
			{ -- Left widgets
				layout = wibox.layout.fixed.horizontal,
				margin(logout_menu(), true, _, _, _, 10),
				--margin(test, true),
				margin(s.taglist),
				margin(spotify_widget({ max_length = 40 }), true),
				margin(promptbox, true),
			},
			-- Middle widget
			margin(s.tasklist, true),
			{ -- Right widgets
				layout = wibox.layout.fixed.horizontal,
				margin(my_systray, true),
				margin(battery_widget()),
				margin(volume_widget()),
				margin(clock),
			},
		})
	else
		s.bar:setup({
			layout = wibox.layout.align.horizontal,
			expand = "none",
			{ -- Left widgets
				layout = wibox.layout.fixed.horizontal,
				margin(s.taglist),
				margin(spotify_widget({ max_length = 40 }), true),
				margin(promptbox),
			},
			-- Middle widget
			margin(s.tasklist, true),
			{ -- Right widgets
				layout = wibox.layout.fixed.horizontal,
				margin(battery_widget()),
				margin(clock),
			},
		})
	end
end)
