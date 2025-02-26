local require, awesome, string = require, awesome, string

local awful = require('awful')

return {
    down = function()
        local value = 0
        awful.spawn.easy_async('brightnessctl -m set 5%-', function(stdout)
            local i = 1
            for e in string.gmatch(stdout, '([^,]+)') do
                if (i == 4) then
                    value = tonumber(string.sub(e, 1, -2)) + 0
                    break
                end
                i = i + 1
            end
            awesome.emit_signal('brightness::change', value)
        end)
    end,
    up = function()
        local value = 0
        awful.spawn.easy_async('brightnessctl -m set 5%+', function(stdout)
            local i = 1
            for e in string.gmatch(stdout, '([^,]+)') do
                if (i == 4) then
                    value = tonumber(string.sub(e, 1, -2)) + 0
                    break
                end
                i = i + 1
            end
            awesome.emit_signal('brightness::change', value)
        end)
    end
}
