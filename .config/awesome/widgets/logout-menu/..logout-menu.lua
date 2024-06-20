local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local HOME = os.getenv("HOME")
local ICON_DIR = HOME .. "/.config/awesome/widgets/logout-menu/icons/"

local worker = {}

worker.widget = function()
	wibox.widget({
		{
			{
				image = ICON_DIR .. "power_w.svg",
				resize = true,
				widget = wibox.widget.imagebox,
			},
			margins = 5,
			layout = wibox.container.margin,
		},
		shape = function(cr, width, height)
			--gears.shape.rounded_rect(cr, width, height, 10)
			gears.shape.circle(cr, width, height, 10)
		end,
		widget = wibox.container.background,
	})
end

worker.toggle = function(parent)
	if parent.visible then
		parent.visible = false
	else
		parent.visible = true
	end
end

return worker.widget
