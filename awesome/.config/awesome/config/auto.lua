local awful = require("awful")

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

-- "Daemons", but not really daemonized, just programs running in the bg.
-- spawn_if_not_running('mpd')
-- spawn_if_not_running('mpDris2')
-- spawn_if_not_running('playerctld')
spawn_if_not_running("nm-applet")
spawn_if_not_running("blueman-applet")
spawn_if_not_running("picom")
spawn_if_not_running_with_shell("xss-lock", "--transfer-sleep-lock lock")
spawn_if_not_running_with_shell("unclutter", "--timeout 0.5")
