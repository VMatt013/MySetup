local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local Debug = require("Debug")

local HOME = os.getenv("HOME")
local ICON_DIR = HOME .. "/.config/awesome/widgets/logout-menu/icons/"

local popup = awful.popup({
	screen = awful.screen.focused(),
	ontop = true,
	visible = false,
	shape = function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, 10)
	end,
	placement = awful.placement.centered,
	border_width = 1,
	border_color = beautiful.bg_focus,
	widget = {},
})

local rows = { layout = wibox.layout.fixed.vertical }
local selected_index = 1 -- Index to keep track of the selected menu item

local args = user_args or {}
local font = args.font or beautiful.font

local onlogout = args.onlogout or function()
	awesome.quit()
end
local onlock = args.onlock or function()
	awful.spawn.with_shell("i3lock")
end
local onreboot = args.onreboot or function()
	awful.spawn.with_shell("/sbin/reboot")
end
local onsuspend = args.onsuspend or function()
	awful.spawn.with_shell("systemctl suspend")
end
local onpoweroff = args.onpoweroff or function()
	awful.spawn.with_shell("/sbin/shutdown now")
end

local onrebootwindows = function()
	awful.spawn.with_shell(
		"sudo efibootmgr -n 0008 2>&1 | tee /tmp/efibootmgr.log",
		false,
		function(exit_code, stdout, stderr)
			if exit_code ~= 0 then
				Debug("efibootmgr failed: ", stderr)
			else
				onreboot()
			end
		end
	)
end

local menu_items = {
	{ name = "Log out", icon_name = "log-out.svg", command = onlogout },
	{ name = "Lock", icon_name = "lock.svg", command = onlock },
	{ name = "Reboot", icon_name = "refresh-cw.svg", command = onreboot },
	{ name = "Reboot to Windows", icon_name = "windows.svg", command = onrebootwindows },
	{ name = "Suspend", icon_name = "moon.svg", command = onsuspend },
	{ name = "Power off", icon_name = "power.svg", command = onpoweroff },
}

local function update_selection()
	for i, row in ipairs(rows) do
		if i == selected_index then
			row.bg = beautiful.bg_focus
		else
			row.bg = beautiful.bg_normal
		end
	end
end

for i, item in ipairs(menu_items) do
	local row = wibox.widget({
		{
			{
				{
					image = ICON_DIR .. item.icon_name,
					resize = false,
					widget = wibox.widget.imagebox,
				},
				{
					text = item.name,
					font = font,
					widget = wibox.widget.textbox,
				},
				spacing = 12,
				layout = wibox.layout.fixed.horizontal,
			},
			forced_width = 300,
			margins = 8,
			layout = wibox.container.margin,
		},
		bg = beautiful.bg_normal,
		widget = wibox.container.background,
	})

	row:buttons(awful.util.table.join(awful.button({}, 1, function()
		popup.visible = false
		item.command()
	end)))

	table.insert(rows, row)
end

popup:setup(rows)

function popup:toggle()
	self.visible = not self.visible
end

-- Update the UI to reflect the initial selection
update_selection()

-- Handle key press events for navigation and selection
local function handle_key(key)
	if key == "Up" then
		selected_index = (selected_index - 2) % #menu_items + 1
	elseif key == "Down" then
		selected_index = selected_index % #menu_items + 1
	elseif key == "Return" or key == "Right" then
		popup.visible = false
		menu_items[selected_index].command()
	end
	update_selection()
end

-- Connect key press signals to the popup
popup:connect_signal("property::visible", function()
	if popup.visible then
		awful.keygrabber.run(function(_, key, event)
			if event == "release" then
				return
			end
			if key == "Escape" then
				popup.visible = false
				awful.keygrabber.stop()
			else
				handle_key(key)
			end
		end)
	else
		awful.keygrabber.stop()
	end
end)

return popup
