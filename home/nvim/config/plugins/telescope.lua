require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = require("telescope.actions").close,
			},
		},
	},
	extensions = {
		["ui-select"] = { require("telescope.themes").get_dropdown() },
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		project = {
			base_dirs = {
				-- {'~/dev/oor/core/subsystems', max_depth = 2},
			},
		},
	},
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")
