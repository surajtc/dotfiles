local colors = require("base16-colorscheme").colors

require("lualine").setup({
	options = {
		theme = "base16",
		component_separators = "",
		section_separators = "",
		globalstatus = true,
	},
	sections = {
		lualine_a = { {
			"mode",
			fmt = function(str)
				return str:sub(1, 1)
			end,
		} },
		lualine_b = { "branch" },
		lualine_c = {
			{
				"buffers",
				icons_enabled = false,
				symbols = { alternate_file = "" },
				buffers_color = {
					active = { fg = colors.base05, bg = colors.base03 },
					inactive = { fg = colors.base04 },
				},
			},
		},
		lualine_x = { "diff", "diagnostics", "searchcount", "selectioncount" },
	},
	winbar = {
		lualine_b = { { "filename", path = 1, newfile_status = true } },
	},
	inactive_winbar = {
		lualine_c = { { "filename", path = 1, newfile_status = true } },
	},
})

-- vim.cmd("highlight MsgArea guifg=" .. colors.base04)
vim.api.nvim_set_hl(0, "MsgArea", { fg = colors.base04 })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.base07 })
