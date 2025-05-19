local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi
local rrect = require("util").rrect

return function(s)
	-- Create a tasklist widget
	return awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = {
			-- Left-clicking a client indicator minimizes it if it's unminimized, or unminimizes
			-- it if it's minimized.
			awful.button(nil, 1, function(c)
				c:activate({ context = "tasklist", action = "toggle_minimization" })
			end),
			-- Right-clicking a client indicator shows the list of all open clients in all visible
			-- tags.
			-- awful.button(nil, 3, function()
			-- 	awful.menu.client_list({ theme = { width = 250 } })
			-- end),
			-- Mousewheel scrolling cycles through clients.
			-- awful.button(nil, 4, function()
			-- 	awful.client.focus.byidx(-1)
			-- end),
			-- awful.button(nil, 5, function()
			-- 	awful.client.focus.byidx(1)
			-- end),
		},
		layout = {
			layout = wibox.layout.flex.horizontal,
			spacing = dpi(8),
		},
		style = {
			-- Colors.
			bg_minimize = beautiful.bg_minimize,
			fg_minimize = beautiful.fg_minimize,
			bg_normal = beautiful.bg_normal,
			fg_normal = beautiful.fg_normal,
			bg_focus = beautiful.bg_focus,
			fg_focus = beautiful.fg_focus,
			bg_urgent = beautiful.bg_urgent,
			fg_urgent = beautiful.fg_urgent,
			-- shape = rrect(),
			shape_border_width = dpi(1),
			shape_border_color = beautiful.border_color_normal,
			shape_border_color_focus = beautiful.border_color_active,
			shape_border_color_minimized = beautiful.border_marked,
			shape_border_color_urgent = beautiful.bg_urgent,
			-- Styling
			font = beautiful.taskbar_font,
			-- disable_icon = false,
			-- maximized = "[+]",
			-- minimized = "[-]",
			-- sticky = "[*]",
			-- floating = "[~]",
			-- ontop = "[^]",
			-- above = "[!]",
		},
		widget_template = {
			widget = wibox.container.background,
			id = "background_role",
			{
				widget = wibox.container.margin,
				margins = {
					left = dpi(8),
					right = dpi(8),
				},
				{
					{
						{
							widget = wibox.widget.imagebox,
							valign = "center",
							id = "icon_role",
						},
						margins = { top = dpi(4), bottom = dpi(4) },
						widget = wibox.container.margin,
					},
					{
						widget = wibox.widget.textbox,
						valign = "center",
						id = "text_role",
					},
					spacing = dpi(8),
					layout = wibox.layout.fixed.horizontal,
				},
			},
		},
	})
end
