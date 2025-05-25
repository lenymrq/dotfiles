local wibox = require("wibox")
local awful = require("awful")
local rrect = require("util").rrect
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local closed_icon = "󰁣"
local opened_icon = "󰁊"

return function(s, height)
	-- Create the systray widget
	local systray = wibox.widget.systray(s)
	systray:set_base_size(height)

	-- Create the text widget that we'll modify
	local button_text = wibox.widget({
		text = closed_icon,
		font = beautiful.nerd_font,
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	-- Create a container for the icon/button
	local systray_button = wibox.widget({
		{
			button_text,
			margins = dpi(4),
			layout = wibox.container.margin,
		},
		shape = rrect(),
		widget = wibox.container.background,
	})

	-- Create a popup to hold the systray
	local popup = awful.popup({
		widget = {
			systray,
			margins = dpi(8),
			layout = wibox.container.margin,
		},
		border_color = beautiful.bg_focus,
		border_width = dpi(1),
		visible = false,
		ontop = true,
		placement = function(d)
			awful.placement.bottom_right(d, {
				margins = {
					bottom = beautiful.bar_height + beautiful.useless_gap,
					right = beautiful.useless_gap,
				},
			})
		end,
		shape = rrect(),
	})

	-- Function to update button appearance based on popup state
	local function update_button()
		if popup.visible then
			button_text:set_text(opened_icon) -- Open state
		else
			button_text:set_text(closed_icon) -- Closed state
		end
	end

	-- Toggle popup visibility when button is clicked
	systray_button:buttons(awful.util.table.join(awful.button({}, 1, function()
		popup.visible = not popup.visible
		update_button()
	end)))

	-- Update button when popup visibility changes for any reason
	popup:connect_signal("property::visible", update_button)

	return wibox.widget({
		systray_button,
		valign = "center",
		layout = wibox.container.place,
	})
end
