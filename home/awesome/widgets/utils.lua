local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local icons_dir = gears.filesystem.get_configuration_dir() .. "theme/icons/"

local _m = {}

function _m.status_widget(textbox, icon)
	return wibox.widget({
		{
			{
				{
					image = icons_dir .. icon .. ".svg",
					stylesheet = "svg { fill: " .. beautiful.fg_focus .. "; }",
					forced_height = beautiful.dpi(11),
					forced_width = beautiful.dpi(11),
					valign = "center",
					widget = wibox.widget.imagebox,
				},
				textbox,
				spacing = beautiful.dpi(3),
				layout = wibox.layout.fixed.horizontal,
			},
			left = beautiful.dpi(4),
			right = beautiful.dpi(4),
			widget = wibox.container.margin,
		},
		bg = beautiful.bg_focus,
		fg = beautiful.fg_focus,
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, 2)
		end,
		widget = wibox.container.background,
	})
end

function _m.separator()
	return wibox.widget({
		orientation = "vertical",
		thickness = beautiful.dpi(3),
		forced_width = beautiful.dpi(3),
		color = beautiful.bg_normal .. "00",
		widget = wibox.widget.separator,
	})
end

return _m
