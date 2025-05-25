local awful = require("awful")
local get_configuration_dir = require("gears.filesystem").get_configuration_dir

return function()
	awful.spawn.with_shell(get_configuration_dir() .. "/script/lock")
end
