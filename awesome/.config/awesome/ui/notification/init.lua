local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local naughty = require('naughty')

return function(n)
   return naughty.layout.box({
      notification = n,
      minimum_width = dpi(125),
      minimum_height = dpi(50),
   })
end
