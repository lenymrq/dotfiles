local awful = require("awful")
local get_configuration_dir = require("gears.filesystem").get_configuration_dir

-- Checks for currently running programs with the same `Command`. If found does nothing,
-- else runs `program`.
local function spawn_if_not_running(program)
	awful.spawn.easy_async_with_shell("pgrep " .. program, function(output)
		if output == nil or output == "" then
			print('"' .. program .. '" started with PID: ' .. awful.spawn(program))
		else
			-- Some programs run several processes, with different PIDs each.
			if output:match("\n.+") then
				print('"' .. program .. '" already running with PID: ' .. output:gsub("\n", ","):sub(1, -2))
			else
				print('"' .. program .. '" already running with PID: ' .. output:gsub("\n", ""))
			end
		end
	end)
end

local function spawn_if_not_running_with_shell(program, argstring)
	awful.spawn.easy_async_with_shell("pgrep " .. program, function(output)
		if output == nil or output == "" then
			print(
				'"'
					.. program
					.. '" started with PID: '
					.. awful.spawn.easy_async_with_shell(program .. " " .. argstring)
			)
		else
			-- Some programs run several processes, with different PIDs each.
			if output:match("\n.+") then
				print('"' .. program .. '" already running with PID: ' .. output:gsub("\n", ","):sub(1, -2))
			else
				print('"' .. program .. '" already running with PID: ' .. output:gsub("\n", ""))
			end
		end
	end)
end

spawn_if_not_running("nm-applet")
spawn_if_not_running("blueman-applet")
spawn_if_not_running("picom")
spawn_if_not_running_with_shell("xss-lock", "--transfer-sleep-lock " .. get_configuration_dir() .. "script/lock")
spawn_if_not_running_with_shell("unclutter", "--timeout 0.5")
