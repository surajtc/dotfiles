local colors = require("mini.base16").config.palette

require("lualine").setup({
	options = {
		theme = "auto",
		component_separators = "",
		section_separators = "",
		globalstatus = true,
		disabled_filetypes = {
			winbar = { "neo-tree" },
		},
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
		lualine_b = { { "filename", path = 1, newfile_status = true, color = { bg = colors.base01 } } },
	},
	inactive_winbar = {
		lualine_c = { { "filename", path = 1, newfile_status = true, color = { fg = colors.base04, bg = colors.base01 } } },
	},
})

vim.api.nvim_set_hl(0, "MsgArea", { fg = colors.base03 })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.base03 })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.base0D })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.base0D, bg = colors.base01 })
vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.base00 })
vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = colors.base01 })
