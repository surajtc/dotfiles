return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local colors = require("catppuccin.palettes").get_palette("mocha")
		local lualine_theme = require("lualine.themes.catppuccin")

		lualine_theme.normal.c.bg = colors.crust
		lualine_theme.inactive.a.bg = colors.crust
		lualine_theme.inactive.b.bg = colors.crust
		lualine_theme.inactive.c.bg = colors.crust

		require("lualine").setup({
			options = {
				theme = lualine_theme,
				component_separators = "",
				section_separators = "",
			},
			sections = {
				lualine_a = { {
					"mode",
					fmt = function(str)
						return str:sub(1, 1)
					end,
				} },
				lualine_c = { { "buffers", hide_filename_extension = false, icons_enabled = false } },
				lualine_x = { { "filetype", icons_enabled = false } },
			},
		})
	end,
}
