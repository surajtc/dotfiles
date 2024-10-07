local wibox = require("wibox")
local watch = require("awful.widget.watch")
local beautiful = require("beautiful")

local M = {}

function M.create_widget(widget_container)
	local speed_widget = wibox.widget({
		{
			id = "txt",
			widget = wibox.widget.textbox,
		},
		layout = wibox.layout.fixed.horizontal,
	})

	local container = widget_container(speed_widget)

	local function get_network_traffic(interface)
		local rx_path = "/sys/class/net/" .. interface .. "/statistics/rx_bytes"
		local tx_path = "/sys/class/net/" .. interface .. "/statistics/tx_bytes"

		local rx_file = io.open(rx_path, "r")
		local tx_file = io.open(tx_path, "r")

		if not rx_file or not tx_file then
			return nil, nil
		end

		local rx = rx_file:read("*a")
		local tx = tx_file:read("*a")

		rx_file:close()
		tx_file:close()

		return tonumber(rx), tonumber(tx)
	end

	local function get_active_interface()
		local interfaces = { "eth0", "wlp0s20f3" } -- Add more common interfaces here
		for _, interface in ipairs(interfaces) do
			local rx, tx = get_network_traffic(interface)
			if rx and tx then
				return interface
			end
		end
		return nil
	end

	local interface = get_active_interface()
	if not interface then
		speed_widget:get_children_by_id("txt")[1]:set_text("No active interface")
		return container
	end

	local rx_prev, tx_prev = get_network_traffic(interface)
	local update_interval = 3 -- Update every 2 seconds

	local function format_speed(speed)
		if speed < 1024 then
			return string.format("%.2f KB/s", speed)
		else
			return string.format("%.2f MB/s", speed / 1024)
		end
	end

	local function update_widget(widget)
		local rx_now, tx_now = get_network_traffic(interface)
		if not rx_now or not tx_now then
			widget:get_children_by_id("txt")[1]:set_text("Error reading " .. interface)
			return
		end

		local rx_speed = (rx_now - rx_prev) / update_interval / 1024 -- Convert to KB/s
		local tx_speed = (tx_now - tx_prev) / update_interval / 1024 -- Convert to KB/s

		local speed, direction
		if tx_speed > rx_speed then
			speed = tx_speed
			direction = "↑" -- Up arrow
		else
			speed = rx_speed
			direction = "↓" -- Down arrow
		end

		local formatted_speed = format_speed(speed)
		widget:get_children_by_id("txt")[1]:set_text(string.format("%s %s", direction, formatted_speed))

		rx_prev, tx_prev = rx_now, tx_now
	end

	-- Update widget
	watch(
		string.format(
			"cat /sys/class/net/%s/statistics/rx_bytes /sys/class/net/%s/statistics/tx_bytes",
			interface,
			interface
		),
		update_interval,
		function(widget, _, _, _, _)
			update_widget(widget)
		end,
		speed_widget
	)

	return container
end

return M
