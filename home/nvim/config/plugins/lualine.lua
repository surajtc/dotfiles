local colors = require("base16-colorscheme").colors

require("lualine").setup({
	options = {
		component_separators = "",
		section_separators = "",
		disabled_filetypes = { "neo-tree" },
		globalstatus = true,
	},
	sections = {
		lualine_a = { {
			"mode",
			fmt = function(str)
				return str:sub(1, 1)
			end,
		} },
		lualine_c = {
			{
				"buffers",
				hide_filename_extension = false,
				icons_enabled = false,
				buffers_color = { active = { bg = colors.base04 } },
			},
		},
		lualine_x = { { "filetype", icons_enabled = false } },
	},
})
