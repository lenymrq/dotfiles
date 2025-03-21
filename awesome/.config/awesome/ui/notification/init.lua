-- Credits to Aproxia for the timeout animation logic.
-- https://github.com/Aproxia-dev
local require, collectgarbage = require, collectgarbage

local awful                   = require('awful')
local beautiful               = require('beautiful')
local gears                   = require('gears')
local naughty                 = require('naughty')
local wibox                   = require('wibox')

local dpi                     = beautiful.xresources.apply_dpi

local widget                  = require('widget')
local color                   = require(beautiful.colorscheme)
local user                    = require('config.user')

local _N                      = {}

function _N.title(n)
   return widget.textbox.scrolling({
      text = '<i>' .. ((n.title == nil or n.title == '') and 'AwesomeWM' or n.title) .. '</i>'
   })
end

function _N.body(n)
   return widget.textbox.scrolling({
      text  = n.message,
      color = color.fg1 .. 'cc',
      dir   = 'vertical'
   })
end

function _N.icon(n)
   return wibox.widget({
      widget          = wibox.widget.imagebox,
      image           = n.icon and gears.surface.crop_surface({
         ratio   = 1,
         surface = gears.surface.load_uncached(n.icon)
      }) or beautiful.notification_default,
      buttons         = { awful.button(nil, 1, function() n:destroy() end) },
      scaling_quality = 'nearest'
   })
end

function _N.timeout()
   return wibox.widget({
      widget           = wibox.widget.progressbar,
      max_value        = 100,
      value            = 0,
      background_color = color.bg1,
      color            = color.accent,
      forced_height    = dpi(3)
   })
end

function _N.actions(n)
   return wibox.widget({
      widget          = naughty.list.actions,
      notification    = n,
      base_layout     = wibox.widget({
         layout  = wibox.layout.flex.horizontal,
         spacing = dpi(2)
      }),
      style           = {
         underline_normal   = false,
         underline_selected = false,
         bg_normal          = color.bg1,
      },
      widget_template = {
         widget = wibox.container.background,
         bg     = color.bg4 .. '20',
         {
            widget  = wibox.container.margin,
            margins = dpi(3),
            {
               widget = wibox.container.place,
               halign = 'center',
               {
                  widget = wibox.widget.textbox,
                  font   = beautiful.font,
                  id     = 'text_role'
               }
            }
         }
      }
   })
end

return function(n)
   -- Store original timeout and set it to an unreachable number.
   local timeout = n.timeout
   -- Using `math.huge` here breaks naughty :P.
   n.timeout = 999999
   local timeout_bar = _N.timeout()

   -- Sections, divided into blocks to avoid YandereDev levels of indentation.
   local titlebox = wibox.widget({
      widget = wibox.container.background,
      bg     = color.bg3,
      {
         widget  = wibox.container.margin,
         margins = { bottom = dpi(1) },
         {
            widget = wibox.container.background,
            bg     = color.bg1,
            {
               widget  = wibox.container.margin,
               margins = {
                  top = dpi(8),
                  bottom = dpi(8),
                  left = dpi(12),
                  right = dpi(12)
               },
               {
                  widget = wibox.container.place,
                  halign = 'center',
                  _N.title(n)
               }
            }
         }
      }
   })

   local contentbox = wibox.widget({
      layout = wibox.layout.align.vertical,
      {
         widget  = wibox.container.margin,
         margins = dpi(12),
         {
            widget   = wibox.container.constraint,
            strategy = 'max',
            width    = dpi(280),
            height   = dpi(250),
            {
               layout = wibox.layout.fixed.vertical,
               _N.body(n),
               {
                  -- Add extra spacing to avoid having it look weird.
                  widget  = wibox.container.margin,
                  margins = { top = dpi(4) },
                  -- This, however, makes you have to hide the spacing itself.
                  visible = #n.actions > 0,
                  _N.actions(n)
               }
            }
         }
      },
      nil,
      {
         layout = wibox.layout.fixed.vertical,
         {
            widget        = wibox.container.background,
            bg            = color.bg3,
            forced_height = dpi(1)
         },
         {
            -- Today I learnt setting a constraint on a progress bar makes it use its minimum
            -- required size. The number you input into width doesn't matter.
            widget   = wibox.container.constraint,
            strategy = 'max',
            width    = 0,
            timeout_bar
         }
      }
   })

   local iconbox = wibox.widget({
      widget  = wibox.container.margin,
      margins = dpi(8),
      {
         widget   = wibox.container.constraint,
         strategy = 'exact',
         width    = dpi(45),
         height   = dpi(45),
         _N.icon(n)
      }
   })

   local layout = naughty.layout.box({
      notification    = n,
      cursor          = 'hand2',
      border_width    = 0,
      widget_template = {
         widget   = wibox.container.constraint,
         strategy = 'max',
         height   = dpi(320),
         width    = dpi(360),
         {
            widget   = wibox.container.constraint,
            strategy = 'min',
            width    = dpi(120),
            {
               widget       = wibox.container.background,
               bg           = color.bg0,
               border_width = dpi(1),
               border_color = color.bg3,
               {
                  layout = wibox.layout.fixed.horizontal,
                  iconbox,
                  {
                     widget       = wibox.container.background,
                     bg           = color.bg3,
                     forced_width = dpi(1)
                  },
                  {
                     layout = wibox.layout.fixed.vertical,
                     titlebox,
                     contentbox
                  }
               }
            }
         }
      }
   })
   -- For some reason, doing this inside the `layout` declaration just doesn't work. You
   -- have to do it imperatively or it'll literally just get ignored.
   layout.buttons = {}

   -- Create an animation for the timeout.
   local anim = require('module.rubato').timed({
      intro      = 0,
      duration   = timeout,
      subscribed = function(pos, time)
         timeout_bar.value = pos
         if time == timeout then
            n:destroy()
            collectgarbage('collect')
         end
      end
   })
   -- Stop the timeout on notification hover.
   layout:connect_signal('mouse::enter', function() anim.pause = true end)
   layout:connect_signal('mouse::leave', function() anim.pause = false end)
   anim.target = 100

   return layout
end
