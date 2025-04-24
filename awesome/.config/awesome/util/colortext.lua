local beautiful = require("beautiful")

return function(txt, color)
	local c = color or beautiful.fg_normal
	return '<span foreground="' .. c .. '">' .. txt .. "</span>"
end
