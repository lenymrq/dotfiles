-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')

-- Standard awesome library
local gears = require 'gears'
local awful = require 'awful'
require 'awful.autofocus'
-- Widget and layout library
local wibox = require 'wibox'
-- Theme handling library
local beautiful = require 'beautiful'
-- Notification library
local naughty = require 'naughty'
local menubar = require 'menubar'
local hotkeys_popup = require 'awful.hotkeys_popup'
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require 'awful.hotkeys_popup.keys'

-- Load Debian menu entries
local debian = require 'debian.menu'
local has_fdo, freedesktop = pcall(require, 'freedesktop')

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify {
    preset = naughty.config.presets.critical,
    title = 'Oops, there were errors during startup!',
    text = awesome.startup_errors,
  }
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal('debug::error', function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then
      return
    end
    in_error = true

    naughty.notify {
      preset = naughty.config.presets.critical,
      title = 'Oops, an error happened!',
      text = tostring(err),
    }
    in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. 'default/theme.lua')
-- beautiful.font = 'JetBrainsMono Nerd Font Mono 10'
beautiful.wallpaper = '/home/lmarques/.local/share/backgrounds/sakurajima-mai-1.png'
beautiful.useless_gap = 0
beautiful.border_width = 2

-- This is used later as the default terminal and editor to run.
-- terminal = 'x-terminal-emulator'
terminal = 'kitty'
editor = os.getenv 'EDITOR' or 'editor'
editor_cmd = terminal .. ' -e ' .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = 'Mod4'

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  -- awful.layout.suit.floating,
  awful.layout.suit.tile,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
  {
    'hotkeys',
    function()
      hotkeys_popup.show_help(nil, awful.screen.focused())
    end,
  },
  { 'manual', terminal .. ' -e man awesome' },
  { 'edit config', editor_cmd .. ' ' .. awesome.conffile },
  { 'restart', awesome.restart },
  {
    'quit',
    function()
      awesome.quit()
    end,
  },
}

local menu_awesome = { 'awesome', myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { 'open terminal', terminal }

if has_fdo then
  mymainmenu = freedesktop.menu.build {
    before = { menu_awesome },
    after = { menu_terminal },
  }
else
  mymainmenu = awful.menu {
    items = {
      menu_awesome,
      { 'Debian', debian.menu.Debian_menu.Debian },
      menu_terminal,
    },
  }
end

mylauncher = awful.widget.launcher { image = beautiful.awesome_icon, menu = mymainmenu }

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a battery widget
mybat = wibox.widget {
  {
    id = 'mytextbox',
    text = 'BAT 100%',
    widget = wibox.widget.textbox,
  },
  layout = wibox.layout.align.horizontal,
  set_battery = function(self, val)
    self.mytextbox.text = 'BAT ' .. tonumber(val) .. '%'
  end,
}

gears.timer {
  timeout = 10,
  call_now = true,
  autostart = true,
  callback = function()
    awful.spawn.easy_async('cat /sys/class/power_supply/BAT0/capacity', function(out)
      mybat.battery = out
    end)
  end,
}

-- Create a ram usage widget
myram = wibox.widget {
  {
    id = 'mytextbox',
    text = 'RAM 0%',
    widget = wibox.widget.textbox,
  },
  layout = wibox.layout.align.horizontal,
  set_usage = function(self, val)
    self.mytextbox.text = 'RAM ' .. tonumber(val) .. '%'
  end,
}

gears.timer {
  timeout = 10,
  call_now = true,
  autostart = true,
  callback = function()
    awful.spawn.easy_async_with_shell('awk \'/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {printf "%.0f", 100-(a/t)*100}\' /proc/meminfo', function(out)
      myram.usage = out
    end)
  end,
}

-- Create a cpu usage widget
mycpu = wibox.widget {
  {
    id = 'mytextbox',
    text = 'CPU 0%',
    widget = wibox.widget.textbox,
  },
  layout = wibox.layout.align.horizontal,
  set_usage = function(self, val)
    self.mytextbox.text = 'CPU ' .. tonumber(val) .. '%'
  end,
}

gears.timer {
  timeout = 10,
  call_now = true,
  autostart = true,
  callback = function()
    awful.spawn.easy_async_with_shell('top -bn2 | grep "Cpu(s)" | sed -n 2p | awk \'{printf "%.0f", 100 - $8}\'', function(out)
      mycpu.usage = out
    end)
  end,
}

-- Create a system monitor widget
mysystemmonitor = wibox.widget {
  mycpu,
  wibox.widget.textbox ' ',
  myram,
  wibox.widget.textbox ' ',
  mybat,
  layout = wibox.layout.fixed.horizontal,
}

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t)
    t:view_only()
  end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
  end)
)

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal('request::activate', 'tasklist', { raise = true })
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list { theme = { width = 250 } }
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == 'function' then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal('property::geometry', set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ '1', '2', '3', '4', '5', '6', '7', '8', '9' }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
  }

  -- Create the wibox
  s.mywibox = awful.wibar { position = 'top', screen = s }

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      mylauncher,
      s.mytaglist,
      s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      mysystemmonitor,
      mykeyboardlayout,
      wibox.widget.systray(),
      mytextclock,
      s.mylayoutbox,
    },
  }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
  -- awful.button({}, 3, function()
  --   mymainmenu:toggle()
  -- end),
  -- awful.button({}, 4, awful.tag.viewnext),
  -- awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
  awful.key({ modkey }, 's', hotkeys_popup.show_help, { description = 'show help', group = 'awesome' }),
  awful.key({ modkey }, 'Left', function()
    awful.client.focus.global_bydirection 'left'
  end, { description = 'focus left', group = 'client' }),
  awful.key({ modkey }, 'Right', function()
    awful.client.focus.global_bydirection 'right'
  end, { description = 'focus right', group = 'client' }),
  awful.key({ modkey }, 'Up', function()
    awful.client.focus.global_bydirection 'up'
  end, { description = 'focus up', group = 'client' }),
  awful.key({ modkey }, 'Down', function()
    awful.client.focus.global_bydirection 'down'
  end, { description = 'focus down', group = 'client' }),
  awful.key({ modkey }, 'Escape', awful.tag.history.restore, { description = 'go back', group = 'tag' }),

  awful.key({ modkey }, 'k', function()
    awful.client.focus.byidx(1)
  end, { description = 'focus next by index', group = 'client' }),
  awful.key({ modkey }, 'j', function()
    awful.client.focus.byidx(-1)
  end, { description = 'focus previous by index', group = 'client' }),
  -- awful.key({ modkey }, 'w', function()
  --   mymainmenu:show()
  -- end, { description = 'show main menu', group = 'awesome' }),

  -- Layout manipulation
  awful.key({ modkey, 'Shift' }, 'k', function()
    awful.client.swap.byidx(1)
  end, { description = 'swap with next client by index', group = 'client' }),
  awful.key({ modkey, 'Shift' }, 'j', function()
    awful.client.swap.byidx(-1)
  end, { description = 'swap with previous client by index', group = 'client' }),
  awful.key({ modkey, 'Ctrl' }, 'h', function()
    awful.screen.focus_bydirection('left', awful.screen.focused())
  end, { description = 'focus the left screen', group = 'screen' }),
  awful.key({ modkey, 'Ctrl' }, 'l', function()
    awful.screen.focus_bydirection('right', awful.screen.focused())
  end, { description = 'focus the right screen', group = 'screen' }),
  awful.key({ modkey, 'Ctrl' }, 'k', function()
    awful.screen.focus_bydirection('up', awful.screen.focused())
  end, { description = 'focus the up screen', group = 'screen' }),
  awful.key({ modkey, 'Ctrl' }, 'j', function()
    awful.screen.focus_bydirection('down', awful.screen.focused())
  end, { description = 'focus the down screen', group = 'screen' }),
  awful.key({ modkey }, 'u', awful.client.urgent.jumpto, { description = 'jump to urgent client', group = 'client' }),
  awful.key({ modkey }, 'Tab', function()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end, { description = 'go back', group = 'client' }),

  -- Standard program
  awful.key({ modkey }, 'Return', function()
    if terminal == 'kitty' then
      awful.spawn(terminal .. ' -1')
    else
      awful.spawn(terminal)
    end
  end, { description = 'open a terminal', group = 'launcher' }),
  awful.key({ modkey, 'Shift' }, 'r', awesome.restart, { description = 'reload awesome', group = 'awesome' }),
  awful.key({ modkey, 'Shift' }, 'e', awesome.quit, { description = 'quit awesome', group = 'awesome' }),

  awful.key({ modkey }, 'p', function()
    awful.tag.incmwfact(0.05)
  end, { description = 'increase master width factor', group = 'layout' }),
  awful.key({ modkey }, 'o', function()
    awful.tag.incmwfact(-0.05)
  end, { description = 'decrease master width factor', group = 'layout' }),
  awful.key({ modkey }, 'i', function()
    awful.tag.setmwfact(0.5)
  end, { description = 'reset master width factor', group = 'layout' }),
  awful.key({ modkey, 'Shift' }, 'p', function()
    awful.tag.incnmaster(1, nil, true)
  end, { description = 'increase the number of master clients', group = 'layout' }),
  awful.key({ modkey, 'Shift' }, 'o', function()
    awful.tag.incnmaster(-1, nil, true)
  end, { description = 'decrease the number of master clients', group = 'layout' }),
  awful.key({ modkey, 'Control' }, 'p', function()
    awful.tag.incncol(1, nil, true)
  end, { description = 'increase the number of columns', group = 'layout' }),
  awful.key({ modkey, 'Control' }, 'o', function()
    awful.tag.incncol(-1, nil, true)
  end, { description = 'decrease the number of columns', group = 'layout' }),
  awful.key({ modkey }, 'space', function()
    awful.layout.inc(1)
  end, { description = 'select next', group = 'layout' }),
  awful.key({ modkey, 'Shift' }, 'space', function()
    awful.layout.inc(-1)
  end, { description = 'select previous', group = 'layout' }),

  -- awful.key({ modkey, 'Control' }, 'n', function()
  --   local c = awful.client.restore()
  --   -- Focus restored client
  --   if c then
  --     c:emit_signal('request::activate', 'key.unminimize', { raise = true })
  --   end
  -- end, { description = 'restore minimized', group = 'client' }),

  -- Prompt
  -- awful.key({ modkey }, 'r', function()
  --   awful.screen.focused().mypromptbox:run()
  -- end, { description = 'run prompt', group = 'launcher' }),

  -- awful.key({ modkey }, 'x', function()
  --   awful.prompt.run {
  --     prompt = 'Run Lua code: ',
  --     textbox = awful.screen.focused().mypromptbox.widget,
  --     exe_callback = awful.util.eval,
  --     history_path = awful.util.get_cache_dir() .. '/history_eval',
  --   }
  -- end, { description = 'lua execute prompt', group = 'awesome' }),
  -- Menubar
  -- awful.key({ modkey }, 'p', function()
  --   menubar.show()
  -- end, { description = 'show the menubar', group = 'launcher' })
  awful.key({ modkey }, 'd', function()
    awful.spawn.with_shell 'rofi -modi drun, run -show drun'
  end, { description = 'show rofi', group = 'launcher' }),
  awful.key({ modkey }, 'x', function()
    awful.spawn.with_shell 'i3lock'
  end, { description = 'lock screen', group = 'awesome' }),
  awful.key({}, 'XF86AudioRaiseVolume', function()
    awful.spawn.easy_async_with_shell 'amixer set Master 10%+'
  end),
  awful.key({}, 'XF86AudioLowerVolume', function()
    awful.spawn.easy_async_with_shell 'amixer set Master 10%-'
  end),
  awful.key({}, 'XF86AudioMute', function()
    awful.spawn.easy_async_with_shell 'amixer set Master toggle'
  end),
  awful.key({}, 'XF86AudioMicMute', function()
    awful.spawn.easy_async_with_shell 'amixer set Capture toggle'
  end),
  awful.key({}, 'XF86MonBrightnessUp', function()
    awful.spawn.easy_async_with_shell 'brightnessctl set 10%+'
  end),
  awful.key({}, 'XF86MonBrightnessDown', function()
    awful.spawn.easy_async_with_shell 'brightnessctl set 10%-'
  end),
  awful.key({ modkey, 'Shift' }, 's', function()
    awful.spawn.with_shell 'flameshot gui'
  end)
)

clientkeys = gears.table.join(
  awful.key({ modkey }, 'f', function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, { description = 'toggle fullscreen', group = 'client' }),
  awful.key({ modkey, 'Shift' }, 'q', function(c)
    c:kill()
  end, { description = 'close', group = 'client' }),
  awful.key({ modkey, 'Control' }, 'space', awful.client.floating.toggle, { description = 'toggle floating', group = 'client' }),
  -- awful.key({ modkey, 'Control' }, 'Return', function(c)
  --   c:swap(awful.client.getmaster())
  -- end, { description = 'move to master', group = 'client' }),
  awful.key({ modkey, 'Ctrl', 'Shift' }, 'h', function(c)
    c:move_to_screen(c.screen:get_next_in_direction 'left')
  end, { description = 'move to left screen', group = 'client' }),
  awful.key({ modkey, 'Ctrl', 'Shift' }, 'l', function(c)
    c:move_to_screen(c.screen:get_next_in_direction 'right')
  end, { description = 'move to right screen', group = 'client' }),
  awful.key({ modkey, 'Ctrl', 'Shift' }, 'k', function(c)
    c:move_to_screen(c.screen:get_next_in_direction 'up')
  end, { description = 'move to up screen', group = 'client' }),
  awful.key({ modkey, 'Ctrl', 'Shift' }, 'j', function(c)
    c:move_to_screen(c.screen:get_next_in_direction 'down')
  end, { description = 'move to down screen', group = 'client' }),
  -- awful.key({ modkey }, 't', function(c)
  --   c.ontop = not c.ontop
  -- end, { description = 'toggle keep on top', group = 'client' }),
  -- awful.key({ modkey }, 'n', function(c)
  --   -- The client currently has the input focus, so it cannot be
  --   -- minimized, since minimized clients can't have the focus.
  --   c.minimized = true
  -- end, { description = 'minimize', group = 'client' }),
  awful.key({ modkey }, 'm', function(c)
    c.maximized = not c.maximized
    c:raise()
  end, { description = '(un)maximize', group = 'client' }),
  awful.key({ modkey }, 't', awful.titlebar.toggle, { description = 'toggle titlebar', group = 'client' })
  -- awful.key({ modkey, 'Control' }, 'm', function(c)
  --   c.maximized_vertical = not c.maximized_vertical
  --   c:raise()
  -- end, { description = '(un)maximize vertically', group = 'client' }),
  -- awful.key({ modkey, 'Shift' }, 'm', function(c)
  --   c.maximized_horizontal = not c.maximized_horizontal
  --   c:raise()
  -- end, { description = '(un)maximize horizontally', group = 'client' })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(
    globalkeys,
    -- View tag only.
    awful.key({ modkey }, '#' .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end, { description = 'view tag #' .. i, group = 'tag' }),
    -- Toggle tag display.
    -- awful.key({ modkey, 'Control' }, '#' .. i + 9, function()
    --   local screen = awful.screen.focused()
    --   local tag = screen.tags[i]
    --   if tag then
    --     awful.tag.viewtoggle(tag)
    --   end
    -- end, { description = 'toggle tag #' .. i, group = 'tag' }),
    -- Move client to tag.
    awful.key({ modkey, 'Shift' }, '#' .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end, { description = 'move focused client to tag #' .. i, group = 'tag' })
    -- Toggle tag on focused client.
    -- awful.key({ modkey, 'Control', 'Shift' }, '#' .. i + 9, function()
    --   if client.focus then
    --     local tag = client.focus.screen.tags[i]
    --     if tag then
    --       client.focus:toggle_tag(tag)
    --     end
    --   end
    -- end, { description = 'toggle focused client on tag #' .. i, group = 'tag' })
  )
end

clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal('request::activate', 'mouse_click', { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal('request::activate', 'mouse_click', { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal('request::activate', 'mouse_click', { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen + awful.placement.centered,
      size_hints_honor = false,
    },
  },

  -- Floating clients.
  {
    rule_any = {
      instance = {
        'DTA', -- Firefox addon DownThemAll.
        'copyq', -- Includes session name in class.
        'pinentry',
      },
      class = {
        'Arandr',
        'Blueman-manager',
        'Gpick',
        'Kruler',
        'MessageWin', -- kalarm.
        'Sxiv',
        'Tor Browser', -- Needs a fixed window size to avoid fingerprinting by screen size.
        'Wpa_gui',
        'veromix',
        'xtightvncviewer',
      },

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        'Event Tester', -- xev.
      },
      role = {
        'AlarmWindow', -- Thunderbird's calendar.
        'ConfigManager', -- Thunderbird's about:config.
        'pop-up', -- e.g. Google Chrome's (detached) Developer Tools.
      },
    },
    properties = { floating = true },
  },

  -- Add titlebars to normal clients and dialogs
  { rule_any = { type = { 'normal', 'dialog' } }, properties = { titlebars_enabled = false } },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal('manage', function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  if not awesome.startup then
    awful.client.setslave(c)
  end

  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal('request::titlebars', function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({}, 1, function()
      c:emit_signal('request::activate', 'titlebar', { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal('request::activate', 'titlebar', { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c):setup {
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout = wibox.layout.fixed.horizontal,
    },
    { -- Middle
      { -- Title
        align = 'center',
        widget = awful.titlebar.widget.titlewidget(c),
      },
      buttons = buttons,
      layout = wibox.layout.flex.horizontal,
    },
    { -- Right
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal(),
    },
    layout = wibox.layout.align.horizontal,
  }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c)
  c:emit_signal('request::activate', 'mouse_enter', { raise = false })
end)

client.connect_signal('focus', function(c)
  c.border_color = beautiful.border_focus
end)
client.connect_signal('unfocus', function(c)
  c.border_color = beautiful.border_normal
end)
-- }}}

-- Autostart
awful.spawn.with_shell 'xss-lock --transfer-sleep-lock -- i3lock --nofork'
awful.spawn.with_shell 'killall nm-applet; nm-applet'
awful.spawn.easy_async_with_shell 'killall picom; picom --experimental-backends'
awful.spawn.easy_async_with_shell 'killall unclutter; unclutter --timeout 0.5'
awful.spawn.easy_async_with_shell 'setxkbmap us'
