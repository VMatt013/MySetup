-- tasklist.lua

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local Debug = require("Debug")

-- Mouse bindings for the tasklist
local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

local function create(s, max_width)
	local max_width = max_width or 300
	local tasklist_widget = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		style = {
			shape = gears.shape.rounded_bar,
		},
		layout = {
			spacing = 5,
			layout = wibox.layout.flex.horizontal,
		},
		widget_template = {
			{
				{
					{
						{
							{
								id = "clienticon",
								widget = awful.widget.clienticon,
							},
							margins = 2,
							widget = wibox.container.margin,
						},
						{
							id = "text_role",
							widget = wibox.widget.textbox,
						},
						layout = wibox.layout.fixed.horizontal,
					},
					left = 10,
					right = 10,
					widget = wibox.container.margin,
				},
				id = "background_role",
				widget = wibox.container.background,
			},
			widget = wibox.container.margin,
			top = 2,
			bottom = 2,
			update_callback = function(self, c, index, clients) end,
		},
	})

	local tasklist_constraint = wibox.container.constraint(tasklist_widget, "max", max_width)

	return tasklist_constraint
end

return create
