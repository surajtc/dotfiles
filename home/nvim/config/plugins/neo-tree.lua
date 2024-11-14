require("neo-tree").setup({
	close_if_last_window = true,
	default_component_configs = {
		indent = {
			indent_marker = "│",
			last_indent_marker = "└",
		},
	},
	window = {
		position = "right",
		width = 30,
	},
	filesystem = {
		filtered_items = {
			visible = true,
			show_hidden_count = true,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
	},
	buffers = { follow_current_file = { enable = true } },
})
