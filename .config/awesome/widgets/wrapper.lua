local debug = require("Debug")

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local wrapper = function(widget, t, r, b, l)
	local wrap = wibox.widget({
		{
			widget,
			top = t or 2,
			right = r or 5,
			bottom = b or 2,
			left = l or 5,
			widget = wibox.container.margin,
		},
		bg = beautiful.bg_normal,
		shape = gears.shape.rounded_rect,
		widget = wibox.container.background,
		visible = true,
	})

	return wrap
end

return wrapper
