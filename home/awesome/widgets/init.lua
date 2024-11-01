local _m = {}

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")

local apps = require("config.apps")
local mod = require("bindings.mod")

local status_widget = require("widgets.utils").status_widget
local separator = require("widgets.utils").separator()

local config_dir = gears.filesystem.get_configuration_dir()

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
		{ "awesome", _m.awesomemenu, gears.color.recolor_image(beautiful.menu_icon, beautiful.colors.base0D) },
		{ "open terminal", apps.terminal },
	},
})

_m.launcher = awful.widget.launcher({
	image = gears.color.recolor_image(beautiful.menu_icon, beautiful.colors.base0D),
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
		bg = beautiful.colors.base05,
		fg = beautiful.colors.base00,
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

local function update_margins(margin_widget, is_selected)
	local left_margin = is_selected and beautiful.dpi(10) or beautiful.dpi(4)
	local right_margin = left_margin

	margin_widget.left = beautiful.dpi(left_margin)
	margin_widget.right = beautiful.dpi(right_margin)
end

function _m.create_taglist(s)
	return awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		widget_template = {
			{
				{
					id = "text_role",
					halign = "center",
					valign = "center",
					widget = wibox.widget.textbox,
				},
				id = "margin_role",
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
			create_callback = function(self, tag, index, tags)
				local margin_widget = self:get_children_by_id("margin_role")[1]
				update_margins(margin_widget, tag.selected)
			end,

			update_callback = function(self, tag, index, tags)
				local margin_widget = self:get_children_by_id("margin_role")[1]
				update_margins(margin_widget, tag.selected)
			end,
		},
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

local function update_marker(widget, is_active)
	widget.color = is_active and beautiful.fg_focus or beautiful.bg_focus
end

function _m.create_tasklist(s)
	return awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		widget_template = {
			{
				{
					{
						id = "marker_role",
						orientation = "vertical",
						thickness = beautiful.dpi(5),
						forced_width = beautiful.dpi(5),
						-- shape = gears.shape.circle,
						widget = wibox.widget.separator,
					},
					left = beautiful.dpi(0),
					right = beautiful.dpi(4),
					widget = wibox.container.margin,
				},
				{
					id = "text_role",
					widget = wibox.widget.textbox,
				},
				layout = wibox.layout.fixed.horizontal,
			},
			id = "background_role",
			widget = wibox.container.background,

			create_callback = function(self, c, index, objects)
				local marker = self:get_children_by_id("marker_role")[1]
				update_marker(marker, c.active)
			end,

			update_callback = function(self, c, index, objects)
				local marker = self:get_children_by_id("marker_role")[1]
				update_marker(marker, c.active)
			end,
		},
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

local cpu = require("widgets.status.cpu").cpu_widget()
local memory = require("widgets.status.memory").memory_widget()
local netspeed = require("widgets.status.netspeed").netspeed_widget()

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
					separator,
					status_widget(_m.textclock, "clock"),
					status_widget(cpu, "cpu"),
					status_widget(memory, "memory"),
					status_widget(netspeed, "netspeed"),
					separator,
					wibox.widget.systray(),
					separator,
					s.layoutbox,
					layout = wibox.layout.fixed.horizontal,
					spacing = beautiful.dpi(4),
				},
			},
		},
	})
end

return _m
