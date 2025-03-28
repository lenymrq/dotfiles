local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')
local gears     = require('gears')
local dpi       = beautiful.xresources.apply_dpi

local util = require('util')

local get_brightness_command = "brightnessctl -m"
local brightness_icon = gears.color.recolor_image(beautiful.icon_path .. 'brightness.svg', beautiful.bar_icon_color)

return function(s)
    local brightness_widget = wibox.widget {
        {
            id = 'brightness_container',
            {
                id     = 'brightness_imagebox',
                image  = brightness_icon,
                forced_height = dpi(15),
                widget = wibox.widget.imagebox
            },
            forced_width = dpi(20),
            halign = 'left',
            widget = wibox.container.place
        },
        {
            id     = 'brightness_textbox',
            markup = util.colortext('NaN'),
            forced_width = dpi(40),
            halign = 'right',
            valign = 'center',
            font = beautiful.font,
            widget = wibox.widget.textbox
        },
        screen = s,
        layout = wibox.layout.fixed.horizontal,
        percentage = 0,
        set_brightness = function(self, val)
            self.percentage = tonumber(val)
            self.text = util.colortext(self.percentage .. '%')
        end,
        set_text = function(self, val)
            self.brightness_textbox.markup = val
        end
    }

    local update_brightness_status = function()
        awful.spawn.easy_async_with_shell(get_brightness_command, function(stdout)
            -- Parse output in format: "intel_backlight,backlight,6144,40%,15360"
            local parts = {}
            for part in stdout:gmatch("[^,]+") do
                table.insert(parts, part)
            end
            local percentage = parts[4]:gsub("%%", "") -- Remove % sign
            brightness_widget.brightness = percentage
        end)
    end

    -- Initial update
    update_brightness_status()

    awesome.connect_signal('brightness::up', function(step)
        awful.spawn.easy_async_with_shell(string.format("brightnessctl set %d%%+", step), function()
            update_brightness_status()
        end)
    end)

    awesome.connect_signal('brightness::down', function(step)
        awful.spawn.easy_async_with_shell(string.format("brightnessctl set %d%%-", step), function()
            update_brightness_status()
        end)
    end)

    gears.timer {
        timeout   = 5,
        call_now  = true,
        autostart = true,
        callback  = function()
            update_brightness_status()
        end
    }

    return brightness_widget
end
