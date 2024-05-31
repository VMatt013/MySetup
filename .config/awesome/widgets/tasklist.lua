local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local theme = require("theme.bar-test")
local rounded = theme.rects.rounded

local dpi = beautiful.xresources.apply_dpi

local create = function(s)
	tasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		style = {
			shape_border_width = 1,
			shape_border_color = "#777777",
			shape = rounded(),
		},
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
					margins = dpi(6),
					widget = wibox.container.margin,
				},
				--margins = dpi(2),
				widget = wibox.container.margin,
			},
			id = "background_role",
			--forced_height = 21,
			--forced_width = 21,
			widget = wibox.container.background,
			create_callback = function(self, c, _, _)
				self:connect_signal("mouse::enter", function()
					awesome.emit_signal("bling::task_preview::visibility", s, true, c)
				end)
				self:connect_signal("mouse::leave", function()
					awesome.emit_signal("bling::task_preview::visibility", s, false, c)
				end)
			end,
		},
		border_color = "#777777",
		border_width = 2,
		ontop = true,
		placement = awful.placement.centered,
		shape = rounded(),
	})

	return tasklist
end

return create
