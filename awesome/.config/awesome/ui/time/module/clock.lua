local require, os = require, os

local beautiful   = require('beautiful')
local wibox       = require('wibox')

local helpers     = require('helpers')
local widget      = require('widget')
local color       = require(beautiful.colorscheme)

return function()
   local hour = wibox.widget({
      widget  = wibox.widget.textclock,
      format  = '%H:%M:%S',
      refresh = 1,
      font    = beautiful.font_bitm .. beautiful.bitm_size * 2,
      halign  = 'center'
   })

   local date = widget.textbox.colored({
      color = color.fg2,
      align = 'center'
   })
   require('gears').timer({
      timeout   = 60,
      call_now  = true,
      autostart = true,
      callback  = function()
         local day = tonumber(os.date('%e'))
         date.text =
             os.date('%A, the ') .. day .. helpers.get_suffix(day) .. os.date(' of %B')
      end
   })

   return wibox.widget({
      layout = wibox.layout.fixed.vertical,
      hour,
      date
   })
end
