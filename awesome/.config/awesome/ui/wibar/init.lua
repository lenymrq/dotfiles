local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi

local module = require(... .. '.module')

local space = dpi(12)

return function(s)
   s.mypromptbox = awful.widget.prompt() -- Create a promptbox.

   -- Create the wibox
   s.mywibox = awful.wibar({
      position = 'top',
      screen   = s,
      height   = beautiful.bar_height,
      widget   = {
         layout = wibox.layout.align.horizontal,
         expand = 'none',
         -- Left widgets.
         {
            layout = wibox.layout.fixed.horizontal,
            module.layoutbox(s),
            module.taglist(s),
            module.tasklist(s),
            spacing = dpi(0)
         },
         -- Middle widgets.
         wibox.widget.textclock(), -- Create a textclock widget.
         -- Right widgets.
         {
            layout = wibox.layout.fixed.horizontal,
            module.volume(s),
            module.brightness(s),
            module.battery(s),
            module.systray(s, beautiful.bar_height - beautiful.bar_height / 6),
            spacing = space
         }
      }
   })
end