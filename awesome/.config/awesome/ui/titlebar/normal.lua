local awful = require("awful")
local wibox = require("wibox")
local bling = require("module.bling")
local dpi = require("beautiful.xresources").apply_dpi

--- The titlebar to be used on normal clients.
return function(c)
	-- Buttons for the titlebar.
	local buttons = {
		awful.button(nil, 1, function()
			c:activate({ context = "titlebar", action = "mouse_move" })
		end),
		awful.button(nil, 3, function()
			c:activate({ context = "titlebar", action = "mouse_resize" })
		end),
	}

	local iconwidget = awful.titlebar.widget.iconwidget(c)

	-- Draws the client titlebar at the default position (top) and size.
	awful.titlebar(c).widget = wibox.widget({
		layout = wibox.layout.align.horizontal,
		-- Left
		{
			layout = wibox.layout.fixed.horizontal,
			wibox.widget({
				iconwidget,
				margins = {
					left = dpi(3),
					top = dpi(3),
					bottom = dpi(3),
				},
				widget = wibox.container.margin,
			}),
			buttons = buttons,
		},
		-- Middle
		{
			layout = wibox.layout.flex.horizontal,
			{ -- Title
				widget = awful.titlebar.widget.titlewidget(c),
				halign = "center",
			},
			buttons = buttons,
		},
		-- Right
		{
			layout = wibox.layout.fixed.horizontal,
			bling.widget.tabbed_misc.titlebar_indicator(c),
			-- awful.titlebar.widget.floatingbutton(c),
			-- awful.titlebar.widget.maximizedbutton(c),
			-- awful.titlebar.widget.stickybutton(c),
			-- awful.titlebar.widget.ontopbutton(c),
			-- awful.titlebar.widget.closebutton(c),
		},
	})
end
