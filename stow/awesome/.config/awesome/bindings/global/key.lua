local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")

require("awful.hotkeys_popup.keys")

local apps = require("config.apps")
local mod = require("bindings.mod")
local widgets = require("widgets")

menubar.utils.terminal = apps.terminal

-- General
awful.keyboard.append_global_keybindings({
	awful.key({ mod.super }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ mod.super }, "w", function()
		widgets.mainmenu:show()
	end, { description = "show main menu", group = "awesome" }),
	awful.key({ mod.super, mod.ctrl }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ mod.super, mod.shift }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
	awful.key({ mod.super }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().promptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" }),
	awful.key({ mod.super }, "Return", function()
		awful.spawn(apps.terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ mod.super }, "r", function()
		awful.screen.focused().promptbox:run()
	end, { description = "run prompt", group = "launcher" }),
	awful.key({ mod.super }, "p", function()
		menubar.show()
	end, { description = "show the menubar", group = "launcher" }),
})

-- Custom Apps
awful.keyboard.append_global_keybindings({
	awful.key({ mod.super }, "b", function()
		awful.spawn(apps.browser)
	end, { description = "open browser - " .. apps.browser, group = "apps" }),
	awful.key({ mod.super, mod.shift }, "b", function()
		awful.spawn(apps.browser_alt)
	end, {
		description = "open alternative browser - " .. apps.browser_alt,
		group = "apps",
	}),
	awful.key({ mod.super }, "e", function()
		awful.spawn(apps.filebrowser)
	end, { description = "open file browser", group = "apps" }),
	awful.key({ mod.super }, "`", function()
		awful.spawn("dm-tool lock")
	end, { description = "lock screen", group = "utils" }),
	awful.key({ mod.super, mod.shift }, "p", function()
		awful.spawn("flameshot gui --clipboard --path " .. os.getenv("HOME") .. "/Pictures")
	end, {
		description = "take screenshot and copy to clipboard",
		group = "utils",
	}),
})

-- Focus
awful.keyboard.append_global_keybindings({
	awful.key({ mod.super }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ mod.super }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	awful.key({ mod.super }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),
	awful.key({ mod.super, mod.ctrl }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ mod.super, mod.ctrl }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ mod.super, mod.ctrl }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:activate({ raise = true, context = "key.unminimize" })
		end
	end, { description = "restore minimized", group = "client" }),
})

-- Layout
awful.keyboard.append_global_keybindings({
	awful.key({ mod.super, mod.shift }, "j", function()
		awful.client.swap.byidx(1)
	end, {
		description = "swap with next client by index",
		group = "client",
	}),
	awful.key({ mod.super, mod.shift }, "k", function()
		awful.client.swap.byidx(-1)
	end, {
		description = "swap with previous client by index",
		group = "client",
	}),
	awful.key(
		{ mod.super },
		"u",
		awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "client" }
	),
	awful.key({ mod.super }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ mod.super }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ mod.super, mod.shift }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, {
		description = "increase the number of master clients",
		group = "layout",
	}),
	awful.key({ mod.super, mod.shift }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, {
		description = "decrease the number of master clients",
		group = "layout",
	}),
	awful.key({ mod.super, mod.ctrl }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, {
		description = "increase the number of columns",
		group = "layout",
	}),
	awful.key({ mod.super, mod.ctrl }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, {
		description = "decrease the number of columns",
		group = "layout",
	}),
	awful.key({ mod.super }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	awful.key({ mod.super, mod.shift }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),
})

-- Tags
awful.keyboard.append_global_keybindings({
	awful.key({ mod.super }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ mod.super }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ mod.super }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
})

awful.keyboard.append_global_keybindings({
	awful.key({
		modifiers = { mod.super },
		keygroup = "numrow",
		description = "only view tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	}),
	awful.key({
		modifiers = { mod.super, mod.ctrl },
		keygroup = "numrow",
		description = "toggle tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
	}),
	awful.key({
		modifiers = { mod.super, mod.shift },
		keygroup = "numrow",
		description = "move focused client to tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	}),
	awful.key({
		modifiers = { mod.super, mod.ctrl, mod.shift },
		keygroup = "numrow",
		description = "toggle focused client on tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end,
	}),
	awful.key({
		modifiers = { mod.super },
		keygroup = "numpad",
		description = "select layout directly",
		group = "layout",
		on_press = function(index)
			local t = awful.screen.focused().selected_tag
			if t then
				t.layout = t.layouts[index] or t.layout
			end
		end,
	}),
})
