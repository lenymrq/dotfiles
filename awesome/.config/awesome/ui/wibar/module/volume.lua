local awful     = require('awful')
local beautiful = require('beautiful')
local naughty   = require('naughty')
local wibox     = require('wibox')
local gears     = require('gears')
local dpi       = beautiful.xresources.apply_dpi

local util = require('util')

local get_volume_command = "amixer sget Master | awk -F'[][]' '/Left:/ { print $2 }' | tr -d '%'"
local get_mute_command = "amixer sget Master | awk '/Left:/ {print $NF}' | tr -d '[]'"
local toggle_mute_command = "amixer sset Master toggle"

local vol0 = gears.color.recolor_image(beautiful.icon_path .. 'volume-0.svg', beautiful.bar_icon_color)
local vol1 = gears.color.recolor_image(beautiful.icon_path .. 'volume-1.svg', beautiful.bar_icon_color)
local vol2 = gears.color.recolor_image(beautiful.icon_path .. 'volume-2.svg', beautiful.bar_icon_color)
local vol_muted = gears.color.recolor_image(beautiful.icon_path .. 'volume-mute.svg', beautiful.bar_icon_color)

local get_volume_icon = function(percentage, is_muted)
   if is_muted then return vol_muted end
   if percentage <= 10 then return vol0
   elseif percentage < 75 then return vol1
   else return vol2 end
end

return function(s)
   local volume_widget = wibox.widget {
      {
         id = 'vol_container',
         {
            id     = 'vol_imagebox',
            image  = vol0,
            forced_height = dpi(15),
            widget = wibox.widget.imagebox
         },
         forced_width = dpi(20),
         halign = 'left',
         widget = wibox.container.place
      },
      {
         id     = 'vol_textbox',
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
      is_muted = false,
      set_volume = function(self, val)
         self.percentage = tonumber(val)
         local color = self.is_muted and beautiful.yellow
         self.text = util.colortext(self.percentage .. '%', color)
         self.icon = get_volume_icon(self.percentage, self.is_muted)
      end,
      set_muted = function(self, is_muted)
         self.is_muted = is_muted
         self.icon = get_volume_icon(self.percentage, self.is_muted)
         self.volume = self.percentage
      end,
      set_icon = function(self, val)
         self.vol_container.vol_imagebox.image = val
      end,
      set_text = function(self, val)
         self.vol_textbox.markup = val
      end,
      set_text_color = function(self, val)
         self.vol_textbox.markup = util.colortext(self.percentage .. '%', val)
      end
   }

   local update_mute_status = function()
      awful.spawn.easy_async_with_shell(get_mute_command, function(stdout)
         local muted = stdout:gsub('%s+', '') == 'off'
         volume_widget.muted = muted
      end)
   end

   local update_volume_status = function()
      awful.spawn.easy_async_with_shell(get_volume_command, function(stdout)
         local volume = stdout:gsub('%s+', '')
         volume_widget.volume = volume
      end)
   end

   -- Initial update
   update_volume_status()
   update_mute_status()

   awesome.connect_signal('audio::mute', function()
      awful.spawn.easy_async_with_shell(toggle_mute_command, function()
         update_mute_status()
         update_volume_status()
      end)
   end)

   awesome.connect_signal('audio::up', function(step)
      local command = "amixer sset Master " .. step .. "%+ | awk -F'[][]' '/Left:/ { print $2 }' | tr -d '%'"
      awful.spawn.easy_async_with_shell(command, function(val)
         volume_widget.volume = val
      end)
   end)

   awesome.connect_signal('audio::down', function(step)
      local command = "amixer sset Master " .. step .. "%- | awk -F'[][]' '/Left:/ { print $2 }' | tr -d '%'"
      awful.spawn.easy_async_with_shell(command, function(val)
         volume_widget.volume = val
      end)
   end)

   gears.timer {
      timeout   = 5,
      call_now  = true,
      autostart = true,
      callback  = function()
         update_volume_status()
         update_mute_status()
      end
   }

   volume_widget:buttons(gears.table.join(
      {
         awful.button({}, 1, function()
            awesome.emit_signal('audio::mute')
         end)
      },
      {
         awful.button({}, 3, function()
            awful.spawn.easy_async('pavucontrol')
         end)
      }
   ))
   
   return volume_widget
end
