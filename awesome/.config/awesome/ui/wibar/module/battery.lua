local awful     = require('awful')
local beautiful = require('beautiful')
local naughty   = require('naughty')
local wibox     = require('wibox')
local gears     = require('gears')
local dpi       = beautiful.xresources.apply_dpi

local util = require('util')

local precentage_command    = 'cat /sys/class/power_supply/BAT0/capacity'
local status_command        = 'cat /sys/class/power_supply/BAT0/status'
local charging              = false

local bat0 = gears.color.recolor_image(beautiful.icon_path .. 'battery-0.svg', beautiful.bar_icon_color)
local bat1 = gears.color.recolor_image(beautiful.icon_path .. 'battery-1.svg', beautiful.bar_icon_color)
local bat2 = gears.color.recolor_image(beautiful.icon_path .. 'battery-2.svg', beautiful.bar_icon_color)
local bat3 = gears.color.recolor_image(beautiful.icon_path .. 'battery-3.svg', beautiful.bar_icon_color)
local bat4 = gears.color.recolor_image(beautiful.icon_path .. 'battery-4.svg', beautiful.bar_icon_color)

local get_battery_icon = function(percentage)
   if percentage < 20 then return bat0
   elseif percentage < 40 then return bat1
   elseif percentage < 60 then return bat2
   elseif percentage < 90 then return bat3
   else return bat4 end
end

return function(s)
   local battery_widget = wibox.widget {
      {
         id = 'bat_container',
         {
            id     = 'bat_imagebox',
            image  = bat0,
            forced_width = dpi(20),
            widget = wibox.widget.imagebox
         },
         widget = wibox.container.place
      },
      {
         id     = 'bat_textbox',
         markup = util.colortext('NaN'),
         forced_width = dpi(40),
         halign = 'right',
         valign = 'center',
         font = beautiful.font,
         widget = wibox.widget.textbox
      },
      screen = s,
      layout = wibox.layout.fixed.horizontal,
      spacing = 5,
      percentage = 0,
      charging = false,
      set_battery = function(self, val)
         self.percentage = tonumber(val)
         local color = charging and beautiful.blue or self.percentage < 10 and beautiful.red
         self.text = util.colortext(val .. '%', color)
         self.icon = get_battery_icon(self.percentage)
      end,
      set_status = function(self, val)
         if val == 'Charging' then
            charging = true
         else
            charging = false
         end
      end,
      set_icon = function(self, val)
         self.bat_container.bat_imagebox.image = val
      end,
      set_text = function(self, val)
         self.bat_textbox.markup = val
      end,
      set_text_color = function(self, val)
         self.bat_textbox.markup = util.colortext(percentage .. '%', val)
      end
   }

   local update_status = function()
      awful.spawn.easy_async(precentage_command,
         function(stdout)
            battery_widget.battery = stdout:gsub("%s+", "")
         end
      )
      awful.spawn.easy_async(status_command,
         function(stdout)
            battery_widget.status = stdout:gsub("%s+", "")
         end
      )
   end

   update_status()

   gears.timer {
      timeout   = 5,
      call_now  = true,
      autostart = true,
      callback  = update_status
   }

   return battery_widget
end
