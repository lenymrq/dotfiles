local require, screen = require, screen

local awful = require('awful')
local ruled = require('ruled')
local gears = require('gears')

local user  = require('config.user')

--- Rules.
-- Rules to apply to new clients.
ruled.client.connect_signal('request::rules', function()
   -- All clients will match this rule.
   ruled.client.append_rule({
      id         = 'global',
      rule       = nil,
      properties = {
         focus     = awful.client.focus.filter,
         raise     = true,
         screen    = awful.screen.preferred,
         placement = awful.placement.centered + awful.placement.no_offscreen,
         callback  = awful.client.setslave,
         size_hints_honor = false,
         shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, user.radius) end
      }
   })

   -- Floating clients.
   ruled.client.append_rule({
      id       = 'floating',
      rule_any = {
         instance = { 'copyq', 'pinentry' },
         class    = {
            'Arandr', 'Blueman-manager', 'Gpick', 'Kruler', 'Sxiv',
            'Tor Browser', 'Wpa_gui', 'veromix', 'xtightvncviewer',
            'Nsxiv', 'mpv', 'Nm-connection-editor'
         },
         -- Note that the name property shown in xprop might be set slightly after
         -- creation of the client and the name shown there might not match defined rules
         -- here.
         name    = {
            'Event Tester'   -- xev.
         },
         role    = {
            'AlarmWindow',   -- Thunderbird's calendar.
            'ConfigManager', -- Thunderbird's about:config.
            'pop-up'         -- e.g. Google Chrome's (detached) Developer Tools.
         }
      },
      properties = { floating = true }
   })

   -- Add titlebars to normal clients and dialogs.
   ruled.client.append_rule({
      id         = 'titlebars',
      rule_any   = { type = { 'normal', 'dialog' } },
      properties = { titlebars_enabled = false     }
   })

   -- Prevent certain clients from forcibly claiming focus.
   -- ruled.client.append_rule({
   --    rule_any   = { class = { 'firefox', 'steam', 'discord' } },
   --    properties = { focus = false }
   -- })

   -- Map certain clients to certain workspaces.
   ruled.client.append_rule({
      rule_any = {
         class = { 'steamwebhelper', 'steam', 'Heroic' }
      },
      properties = {
         tag      = screen[1].tags[user.tags],
         floating = true
      }
   })
   ruled.client.append_rule({
      rule_any = {
         class = { 'Code', 'jetbrains-idea', 'jetbrains-webstorm' }
      },
      properties = { tag = screen[1].tags[1] }
   })
   ruled.client.append_rule({
      rule_any = {
         class = { 'org.mozilla.firefox', 'Chromium-browser' }
      },
      properties = { tag = screen[1].tags[2] }
   })
   -- ruled.client.append_rule({
   --    rule_any = {
   --       class = { 'Alacritty' }
   --    },
   --    properties = { tag = screen[1].tags[3] }
   -- })
   ruled.client.append_rule({
      rule_any = {
         class = { 'discord', 'vesktop', 'Slack' }
      },
      properties = { tag = screen[1].tags[4] }
   })
end)

-- Floating windows are `always on top` by default. Breaks fullscreen for some reason??
-- client.connect_signal("property::floating", function(c) c.ontop = c.floating end)
