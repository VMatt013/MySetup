local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local Debug = require("Debug")

local wrapper = function(widget)
	local wrap = wibox.widget({
		{
			widget,
			top = 1,
			right = 5,
			bottom = 1,
			left = 5,
			widget = wibox.container.margin,
		},
		bg = beautiful.bg_normal,
		shape = gears.shape.rounded_rect,
		widget = wibox.container.background,
		visible = true,
		update_callback = function(self)
			Debug(_, "test")
		end,

		set_visibility = function(self, is_visible)
			self.visible = is_visible
		end,
	})

	--

	return wrap
end

local margin = function(widget, use_wrap, t, r, b, l)
	use_wrap = use_wrap or false

	if use_wrap then
		widget = wrapper(widget)
		widget:set_visibility(true)
	end

	local margin = wibox.widget({
		{
			widget,

			widget = wibox.container.background,
		},
		widget = wibox.container.margin,
		top = t or 1,
		right = r or 5,
		bottom = b or 1,
		left = l or 5,
	})
	return margin
end

return margin
