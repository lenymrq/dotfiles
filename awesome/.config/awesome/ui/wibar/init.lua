local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local module = require(... .. ".module")

return function(s)
	s.mypromptbox = awful.widget.prompt() -- Create a promptbox.

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		height = beautiful.bar_height,
		bg = beautiful.bg_normal,
		widget = {
			layout = wibox.layout.align.horizontal,
			expand = "none",
			-- Left widgets.
			{
				layout = wibox.layout.fixed.horizontal,
				{
					module.layoutbox(s),
					margins = { left = dpi(4), top = dpi(4), bottom = dpi(4) },
					widget = wibox.container.margin,
				},
				module.taglist(s),
				-- module.tasklist(s),
				spacing = dpi(8),
			},
			-- Middle widgets.
			wibox.widget.textclock(), -- Create a textclock widget.
			-- Right widgets.
			{
				{
					layout = wibox.layout.fixed.horizontal,
					module.volume(s),
					module.brightness(s),
					module.battery(s),
					spacing = dpi(12),
				},
				margins = { right = dpi(6) },
				widget = wibox.layout.margin,
			},
		},
	})
end
