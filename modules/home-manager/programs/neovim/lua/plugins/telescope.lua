require("telescope").setup({
	defaults = {
		mappings = {
			i = { ["<esc>"] = require("telescope.actions").close },
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
	},
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")
