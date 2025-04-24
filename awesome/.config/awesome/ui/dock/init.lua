local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local module = require(... .. ".module")
local util = require("util")

local size = dpi(62)
local margin = beautiful.useless_gap or dpi(4)

return function(s)
	local dock = awful.popup({
		widget = module.tasklist(s, size),
		shape = util.rrect(),
		border_color = beautiful.fg_normal,
		border_width = dpi(1),
		ontop = true,
		placement = function(c)
			awful.placement.bottom(c, { margins = margin })
		end,
		visible = false,
	})

	local function show_dock()
		dock.visible = true
	end

	local function hide_dock()
		dock.visible = false
	end

	local trigger_area = wibox({
		screen = s,
		height = margin,
		width = s.geometry.width,
		x = s.geometry.x,
		y = s.geometry.height - margin,
		visible = true,
		ontop = true,
		bg = "#00000000",
		input_passthrough = false,
	})

	local mouse_in_dock = false
	local mouse_in_trigger = false

	local hide_timer = gears.timer({
		timeout = 1,
		callback = function()
			if not mouse_in_dock and not mouse_in_trigger then
				hide_dock()
			end
		end,
	})

	trigger_area:connect_signal("mouse::enter", function()
		mouse_in_trigger = true
		show_dock()
		hide_timer:stop()
	end)
	trigger_area:connect_signal("mouse::leave", function()
		mouse_in_trigger = false
		if not mouse_in_dock then
			hide_timer:start()
		end
	end)
	dock:connect_signal("mouse::enter", function()
		mouse_in_dock = true
	end)
	dock:connect_signal("mouse::leave", function()
		mouse_in_dock = false
		if not mouse_in_trigger then
			hide_timer:start()
		end
	end)
	client.connect_signal("focus", function()
		hide_timer:stop()
		show_dock()
		hide_timer:start()
	end)

	return dock
end
