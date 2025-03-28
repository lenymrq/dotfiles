local awful     = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

local util   = require('util')

local margin = beautiful.useless_gap

return function(s, size)
   -- Create a tasklist widget
   return awful.widget.tasklist {
      screen   = s,
      filter   = awful.widget.tasklist.filter.currenttags,
      buttons  = {
         -- Left-clicking a client indicator minimizes it if it's unminimized, or unminimizes
         -- it if it's minimized.
         awful.button(nil, 1, function(c)
            c:activate({ context = 'tasklist', action = 'toggle_minimization' })
         end),
         -- Right-clicking a client indicator shows the list of all open clients in all visible 
         -- tags.
         awful.button(nil, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
         -- Mousewheel scrolling cycles through clients.
         -- awful.button(nil, 4, function() awful.client.focus.byidx(-1) end),
         -- awful.button(nil, 5, function() awful.client.focus.byidx( 1) end)
      },
      layout   = {
         forced_num_rows = 1,
         layout = wibox.layout.grid.horizontal
      },
      widget_template = {
         {
            {
               id     = 'clienticon',
               widget = awful.widget.clienticon,
            },
            margins = dpi(8),
            widget  = wibox.container.margin,
         },
         id              = 'background_role',
         forced_width    = size,
         forced_height   = size,
         widget          = wibox.container.background,
         create_callback = function(self, c, index, objects) --luacheck: no unused
            self:get_children_by_id('clienticon')[1].client = c
         end,
      },
   }
end
