local _m = {}

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")

local apps = require("config.apps")
local mod = require("bindings.mod")

local ram_widget = require("widgets.ram_widget")
local cpu_widget = require("widgets.cpu_widget")
local speed_widget = require("widgets.speed_widget")

_m.awesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", apps.terminal .. " -e man awesome" },
	{ "edit config", apps.editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

_m.mainmenu = awful.menu({
	items = {
		{ "awesome", _m.awesomemenu, beautiful.arch_icon },
		{ "open terminal", apps.terminal },
	},
})

_m.launcher = awful.widget.launcher({
	image = beautiful.arch_icon,
	menu = _m.mainmenu,
})

_m.textclock = wibox.widget.textclock()

function _m.widget_container(widget)
	return wibox.widget({
		{
			widget,
			margins = 2,
			widget = wibox.container.margin,
		},
		bg = beautiful.colors.lavender.hex,
		fg = beautiful.colors.crust.hex,
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, 2)
		end,
		widget = wibox.container.background,
	})
end

function _m.create_promptbox()
	return awful.widget.prompt()
end

function _m.create_layoutbox()
	return awful.widget.layoutbox({
		screen = s,
		buttons = {
			awful.button({}, 1, function()
				awful.layout.inc(1)
			end),
			awful.button({}, 3, function()
				awful.layout.inc(-1)
			end),
			awful.button({}, 4, function()
				awful.layout.inc(-1)
			end),
			awful.button({}, 5, function()
				awful.layout.inc(1)
			end),
		},
	})
end

function _m.create_taglist(s)
	return awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = {
			awful.button({}, 1, function(t)
				t:view_only()
			end),
			awful.button({ mod.super }, 1, function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),
			awful.button({}, 3, awful.tag.viewtoggle),
			awful.button({ mod.super }, 3, function(t)
				if client.focus then
					client.focus:toggle_tag(t)
				end
			end),
			awful.button({}, 4, function(t)
				awful.tag.viewprev(t.screen)
			end),
			awful.button({}, 5, function(t)
				awful.tag.viewnext(t.screen)
			end),
		},
	})
end

function _m.create_tasklist(s)
	return awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = {
			awful.button({}, 1, function(c)
				c:activate({ context = "tasklist", action = "toggle_minimization" })
			end),
			awful.button({}, 3, function()
				awful.menu.client_list({ theme = { width = 250 } })
			end),
			awful.button({}, 4, function()
				awful.client.focus.byidx(-1)
			end),
			awful.button({}, 5, function()
				awful.client.focus.byidx(1)
			end),
		},
	})
end

function _m.create_wibox(s)
	return awful.wibar({
		position = "top",
		screen = s,
		widget = {
			widget = wibox.container.margin,
			margins = {
				top = beautiful.dpi(2),
				bottom = beautiful.dpi(2),
				left = beautiful.dpi(8),
				right = beautiful.dpi(8),
			},
			{
				layout = wibox.layout.align.horizontal,
				spacing = beautiful.dpi(6),
				{ -- Left widgets
					layout = wibox.layout.fixed.horizontal,
					spacing = beautiful.dpi(6),
					_m.launcher,
					s.taglist,
					s.promptbox,
				},
				s.tasklist, -- Middle widget
				{ -- Right widgets
					layout = wibox.layout.fixed.horizontal,
					spacing = beautiful.dpi(6),
					ram_widget.create_widget(_m.widget_container),
					cpu_widget.create_widget(_m.widget_container),
					speed_widget.create_widget(_m.widget_container),
					_m.widget_container(_m.textclock),
					_m.widget_container(wibox.widget.systray()),
					s.layoutbox,
				},
			},
		},
	})
end

return _m
