local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local function create_notification_button()
	-- Create the button widget
	local notif_button = wibox.widget({
		{
			{
				text = "🔔",
				widget = wibox.widget.textbox,
			},
			margins = beautiful.dpi(4),
			widget = wibox.container.margin,
		},
		bg = beautiful.bg_normal,
		widget = wibox.container.background,
	})

	-- Create the popup
	local popup = awful.popup({
		ontop = true,
		visible = false,
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, 4)
		end,
		border_width = 1,
		border_color = beautiful.border_color,
		maximum_width = 400,
		offset = { y = 5 },
		widget = {
			{
				{
					text = "Hello!",
					widget = wibox.widget.textbox,
				},
				margins = 10,
				widget = wibox.container.margin,
			},
			bg = beautiful.bg_normal,
			widget = wibox.container.background,
		},
	})

	-- Add hover effect to button
	notif_button:connect_signal("mouse::enter", function(c)
		c.bg = beautiful.bg_focus
	end)
	notif_button:connect_signal("mouse::leave", function(c)
		c.bg = beautiful.bg_normal
	end)

	-- Toggle popup on button click
	notif_button:connect_signal("button::press", function()
		if popup.visible then
			popup.visible = false
		else
			-- Place popup near the button
			popup:move_next_to(mouse.current_widget_geometry)
		end
	end)

	-- Hide popup when clicking outside
	awesome.connect_signal("root::pressed", function()
		popup.visible = false
	end)

	return notif_button
end

return create_notification_button
