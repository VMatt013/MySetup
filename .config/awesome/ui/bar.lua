local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local dpi = beautiful.xresources.apply_dpi
local theme = require("theme.bar-test")
---------------------
--WIdgets------------
---------------------

local promptbox = awful.widget.prompt()
local clock = wibox.widget.textclock()
local battery_widget = require("widgets.battery-status.battery")
local logout_menu = require("widgets.logout-menu.logout-menu")
local volume_widget = require("widgets.pactl.volume")
local spotify_widget = require("widgets.spotify")
local my_systray = wibox.widget.systray({
	bg = "ff0000",
})

local margin = wibox.container.margin

awful.screen.connect_for_each_screen(function(s)
	awful.tag({ "1", "2", "3" }, s, awful.layout.layouts[1])

	s.tasklist = require("widgets.tasklist")(s)
	s.taglist = require("widgets.taglist")(s)
	--Taglist-----------
	--------------------

	--Bar---------------
	--------------------
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
	})

	s.bar:setup({
		layout = wibox.layout.align.horizontal,
		expand = "none",
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			margin(logout_menu(), 10, 10, 1, 1),
			margin(s.taglist, 0, 10, 1, 1),
			spotify_widget({ max_length = 40 }),
			margin(promptbox, 0, 10, 1, 1),
		},
		--margin(tasklist,0,10,1,1), -- Middle widget
		s.tasklist,
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			margin(my_systray, 0, 10, 1, 1),
			margin(battery_widget(), 0, 10, 1, 1),
			margin(volume_widget(), 0, 10, 1, 1),
			--	margin(brightness_widget(), 0, 10, 1, 1),
			margin(clock, 0, 10, 1, 1),
			--margin(s.mylayoutbox,0,10,1,1),
		},
	})
end)
