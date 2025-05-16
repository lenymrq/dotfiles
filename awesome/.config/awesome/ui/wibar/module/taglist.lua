local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local mod = require("binds.mod")
local modkey = mod.modkey

local dpi = require("beautiful.xresources").apply_dpi

return function(s)
	local icon_inactive_empty = ""
	local icon_inactive_single = ""
	local icon_inactive_many = ""
	local icon_selected = ""

	local inner_margin_width = dpi(2)

	local font = "JetBrainsMono Nerd Font Mono 16" -- any nerd font in mono variant should work

	local update_tags = function(self, c3)
		local tagicon = self:get_children_by_id("icon_role")[1]
		local inner = self:get_children_by_id("inner_margin")[1]
		inner.left = inner_margin_width
		inner.right = inner_margin_width

		if c3.selected then
			tagicon.text = icon_selected
		else
			if #c3:clients() == 0 then
				tagicon.text = icon_inactive_empty
			elseif #c3:clients() == 1 then
				tagicon.text = icon_inactive_single
			else
				tagicon.text = icon_inactive_many
			end
		end
	end

	-- Create a taglist widget
	return awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		layout = {
			spacing = dpi(4),
			layout = wibox.layout.fixed.horizontal,
		},
		buttons = {
			-- Left-clicking a tag changes to it.
			awful.button(nil, 1, function(t)
				t:view_only()
			end),
			-- Mod + Left-clicking a tag sends the currently focused client to it.
			awful.button({ modkey }, 1, function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),
			-- Right-clicking a tag makes its contents visible in the current one.
			awful.button(nil, 3, awful.tag.viewtoggle),
			-- Mod + Right-clicking a tag makes the currently focused client visible
			-- in it.
			awful.button({ modkey }, 3, function(t)
				if client.focus then
					client.focus:toggle_tag(t)
				end
			end),
			-- Mousewheel scrolling cycles through tags.
			-- awful.button(nil, 4, function(t) awful.tag.viewprev(t.screen) end),
			-- awful.button(nil, 5, function(t) awful.tag.viewnext(t.screen) end)
		},
		widget_template = {
			{
				id = "icon_role",
				font = font,
				text = icon_inactive_empty,
				widget = wibox.widget.textbox,
			},
			id = "inner_margin",
			left = #s.tags == 1 and 0 or inner_margin_width,
			right = #s.tags == 1 and 0 or inner_margin_width,
			widget = wibox.container.margin,

			create_callback = function(self, c3)
				update_tags(self, c3)
			end,

			update_callback = function(self, c3)
				update_tags(self, c3)
			end,
		},
	})
end
