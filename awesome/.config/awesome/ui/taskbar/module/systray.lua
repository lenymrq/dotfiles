local wibox = require("wibox")

return function(s, height)
	local systray = wibox.widget.systray(s)
	systray:set_base_size(height)

	return wibox.widget({
		systray,
		valign = "center",
		layout = wibox.container.place,
	})
end

