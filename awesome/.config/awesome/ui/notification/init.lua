local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local naughty = require("naughty")

return function(n)
	return naughty.layout.box({
		notification = n,
		type = "notification",
		minimum_width = beautiful.notification_min_width,
		minimum_height = beautiful.notification_min_height,
	})
end
