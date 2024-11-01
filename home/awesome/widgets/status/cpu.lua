local wibox = require("wibox")
local watch = require("awful.widget.watch")

local M = {}

function M.cpu_widget()
	local widget = wibox.widget({
		{
			id = "txt_role",
			widget = wibox.widget.textbox,
		},
		layout = wibox.layout.fixed.horizontal,
	})

	-- Function to get CPU usage
	local function get_usage()
		local file = io.open("/proc/stat", "r")

		if file == nil then
			return
		end

		local cpu_usage = file:read("*l")
		file:close()

		local _, user, nice, system, idle, iowait, irq, softirq, steal, _, _ =
			cpu_usage:match("(%w+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)")

		local total = user + nice + system + idle + iowait + irq + softirq + steal
		local idle_total = idle + iowait

		return total, idle_total
	end

	local total_prev, idle_prev = get_usage()

	local function update_widget()
		local total_now, idle_now = get_usage()
		local total_diff = total_now - total_prev
		local idle_diff = idle_now - idle_prev

		local cpu_usage = math.floor((1 - (idle_diff / total_diff)) * 100)
		widget:get_children_by_id("txt_role")[1]:set_text(string.format("%d%%", cpu_usage))

		total_prev = total_now
		idle_prev = idle_now
	end

	-- Update every 2 seconds
	watch("cat /proc/stat", 3, function(_, _, _, _, exitcode)
		if exitcode == 0 then
			update_widget()
		end
	end)

	return widget
end

return M
