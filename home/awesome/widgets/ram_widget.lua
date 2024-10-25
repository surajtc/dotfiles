local wibox = require("wibox")
local watch = require("awful.widget.watch")

local M = {}

function M.create_widget(widget_container)
	local ram_widget = wibox.widget({
		{
			id = "txt",
			widget = wibox.widget.textbox,
		},
		layout = wibox.layout.fixed.horizontal,
	})

	local container = widget_container(ram_widget)

	local function update_widget(widget, stdout)
		local total, used, free, shared, buff_cache, available =
			stdout:match("(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)")

		-- Convert values to numbers
		total = tonumber(total)
		used = tonumber(used)

		-- Format used memory
		local used_formatted
		if used >= 1024 then
			used_formatted = string.format("%.2f GB", used / 1024)
		else
			used_formatted = string.format("%.2f MB", used)
		end

		widget:get_children_by_id("txt")[1]:set_text(string.format(" %s", used_formatted))
	end

	watch("free -m", 5, update_widget, ram_widget)

	return container
end

return M
