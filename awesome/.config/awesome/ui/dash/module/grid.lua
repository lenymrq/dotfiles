local require   = require

local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')

local dpi       = beautiful.xresources.apply_dpi

local color     = require(beautiful.colorscheme)
local widget    = require('widget')
local icons     = require('theme.icons')

-- local net = require('signal.system.network')

return function()
   -- Returns a grid entry, with an icon, title, and body.
   -- @param args:
   --    - title: the entry title.
   --    - body: the entry body.
   --    - icon: the icon in normal state.
   --    - on_click: the action to execute on icon click.
   local function entry(args)
      local title = widget.textbox.colored({
         text = args.title
      })
      local body = widget.textbox.colored({
         text  = args.body,
         color = color.fg1
      })
      local icon = widget.textbox.colored({
         text  = args.icon,
         font  = icons.font .. icons.size * 2,
         align = 'center'
      })

      local w = wibox.widget({
         widget       = wibox.container.background,
         bg           = color.bg1,
         border_width = dpi(1),
         border_color = color.bg3,
         {
            widget  = wibox.container.margin,
            margins = dpi(8),
            {
               layout  = wibox.layout.fixed.horizontal,
               spacing = dpi(6),
               {
                  widget  = wibox.container.margin,
                  margins = dpi(4),
                  icon
               },
               {
                  widget = wibox.container.place,
                  valign = 'center',
                  halign = 'left',
                  {
                     layout = wibox.layout.fixed.vertical,
                     title,
                     body
                  }
               }
            }
         },
         buttons = {
            awful.button(nil, 1, args.on_click)
         }
      })
      w:connect_signal('mouse::enter', function(self)
         self.border_color = color.accent
         icon.color        = color.accent
      end)
      w:connect_signal('mouse::leave', function(self)
         self.border_color = color.bg3
         icon.color        = color.fg0
      end)

      return w
   end

   local network = entry({
      title    = 'Network',
      body     = 'Settings',
      icon     = icons['net_wifi_normal'],
      -- on_click = function() net:toggle_networking() end
      on_click = function() awful.spawn('nm-connection-editor') end
   })
   local bluetooth = entry({
      title    = 'Bluetooth',
      body     = 'Settings',
      icon     = icons['bluez_scanning'],
      on_click = function() awful.spawn('blueman-manager') end
   })

   return wibox.widget({
      layout = wibox.layout.grid,
      orientation = 'horizontal',
      expand = true,
      spacing = dpi(8),
      network,
      bluetooth
   })
end
