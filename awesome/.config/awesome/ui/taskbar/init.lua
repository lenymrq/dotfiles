local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local module = require(... .. ".module")

return function(s)
	s.mypromptbox = awful.widget.prompt() -- Create a promptbox.

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "bottom",
		height = beautiful.taskbar_height,
		screen = s,
		bg = beautiful.bg_normal,
		widget = {
			layout = wibox.layout.align.horizontal,
			-- Left widgets.
			{
				{
					layout = wibox.layout.fixed.horizontal,
					module.launcher(),
					s.mypromptbox,
				},
				margins = dpi(4),
				widget = wibox.layout.margin,
			},
			-- Middle widgets.
			{
				-- module.tasklist(s),
				widget = wibox.container.background,
				{
					widget = wibox.container.margin,
					margins = {
						left = dpi(4),
						right = dpi(4),
						top = dpi(4),
						bottom = dpi(4),
					},
					module.tasklist(s),
				},
			},
			-- Right widgets.
			{
				layout = wibox.layout.fixed.horizontal,
				awful.widget.keyboardlayout(), -- Keyboard map indicator and switcher.
				module.systray(s, beautiful.taskbar_height - beautiful.taskbar_height / 6),
			},
		},
	})
end
