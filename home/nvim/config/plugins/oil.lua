local detail = false

require("oil").setup({
	default_file_explorer = true,
	float = {
		padding = 4,
		preview_split = "right",
	},
	keymaps = {
		["gd"] = {
			desc = "Toggle file detail view",
			callback = function()
				detail = not detail
				if detail then
					require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
				else
					require("oil").set_columns({ "icon" })
				end
			end,
		},
	},
})
