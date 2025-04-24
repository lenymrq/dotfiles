local gears = require("gears")
local beautiful = require("beautiful")

return function(r)
	local radius = r or beautiful.radius
	return function(c, w, h)
		gears.shape.rounded_rect(c, w, h, radius)
	end
end
