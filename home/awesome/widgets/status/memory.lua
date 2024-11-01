local wibox = require("wibox")
local watch = require("awful.widget.watch")

local M = {}

function M.memory_widget()
	local widget = wibox.widget({
		{
			id = "text_role",
			widget = wibox.widget.textbox,
		},
		layout = wibox.layout.fixed.horizontal,
	})

	local function update_widget(w, stdout)
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

		w:get_children_by_id("text_role")[1]:set_text(string.format("%s", used_formatted))
	end

	watch("free -m", 5, update_widget, widget)

	return widget
end

return M
