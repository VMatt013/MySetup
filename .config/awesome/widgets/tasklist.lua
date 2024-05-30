local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local theme = require("theme/bar-test")

local dpi = beautiful.xresources.apply_dpi

local create = function(screen)
	return awful.widget.tasklist({
		screen = screen,
		filter = awful.widget.tasklist.filter.currenttags,

		-- sort clients by tags
		source = function()
			local ret = {}

			for _, t in ipairs(s.tags) do
				gears.table.merge(ret, t:clients())
			end

			return ret
		end,
		buttons = {
			awful.button({}, 1, function(c)
				if not c.active then
					c:activate({
						context = "through_dock",
						switch_to_tag = true,
					})
				else
					c.minimized = true
				end
			end),
			awful.button({}, 4, function()
				awful.client.focus.byidx(-1)
			end),
			awful.button({}, 5, function()
				awful.client.focus.byidx(1)
			end),
		},
		style = {
			shape = gears.shape.circle,
			shape_border_width = 1,
			shape_border_color = "#777777",
		},
		layout = {
			spacing = dpi(4),
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				{
					{
						id = "icon_role",
						widget = wibox.widget.imagebox,
					},
					--margins = dpi(2),
					margins = dpi(6),
					widget = wibox.container.margin,
				},
				--margins = dpi(2),
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		},
		border_color = "#777777",
		border_width = 2,
		ontop = true,
		placement = awful.placement.centered,
		shape = theme.rects.rounded(),
	})
end
