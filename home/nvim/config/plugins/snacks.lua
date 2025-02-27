require("mini.icons").setup()

require("snacks").setup({
	dashboard = {
		enabled = true,
		sections = {
			{ section = "header" },
			{ section = "recent_files", title = "Recent Files", padding = 1 },
			{ section = "projects", title = "Projects", padding = 1 },
		},
	},
	indent = {
		enabled = true,
		indent = {
			char = "▏",
		},
		scope = {
			char = "▏",
		},
		animate = { enabled = false },
	},
})
