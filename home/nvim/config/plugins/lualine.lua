local colors = require("mini.base16").config.palette

vim.api.nvim_set_hl(0, "MsgArea", { fg = colors.base03 })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.base03 })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.base0D })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.base07, bg = colors.base01 })
vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.base00 })
vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = colors.base01 })
vim.api.nvim_set_hl(0, "SnacksIndent", { fg = colors.base02 })
vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = colors.base03 })

local lualine_theme = {
	normal = {
		a = { fg = colors.base00, bg = colors.base0D, gui = "bold" },
		b = { fg = colors.base04, bg = colors.base02 },
		c = { fg = colors.base04, bg = colors.base01 },
	},
	insert = {
		a = { fg = colors.base00, bg = colors.base0B, gui = "bold" },
		b = { fg = colors.base04, bg = colors.base02 },
	},
	visual = {
		a = { fg = colors.base00, bg = colors.base0E, gui = "bold" },
		b = { fg = colors.base04, bg = colors.base02 },
	},
	replace = {
		a = { fg = colors.base00, bg = colors.base08, gui = "bold" },
		b = { fg = colors.base04, bg = colors.base02 },
	},
	command = {
		a = { fg = colors.base00, bg = colors.base0A, gui = "bold" },
		b = { fg = colors.base04, bg = colors.base02 },
	},
	inactive = {
		a = { fg = colors.base04, bg = colors.base01 },
		b = { fg = colors.base04, bg = colors.base01 },
		c = { fg = colors.base04, bg = colors.base01 },
	},
}

local arrow_status = require("arrow.statusline")

require("lualine").setup({
	options = {
		theme = lualine_theme,
		component_separators = "",
		section_separators = "",
		globalstatus = true,
		disabled_filetypes = {
			winbar = { "neo-tree" },
		},
	},
	tabline = {
		lualine_a = {
			{
				"tabs",
				use_mode_colors = true,
			},
		},
		lualine_b = {
			{
				"buffers",
				icons_enabled = false,
				symbols = { alternate_file = "" },
			},
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
				"filename",
				fmt = function(str)
					if arrow_status.is_on_arrow_file() then
						return " (" .. arrow_status.text_for_statusline() .. ") " .. str
					end
					return str
				end,
			},
		},
		lualine_x = { "diff", "diagnostics", "searchcount", "selectioncount" },
	},
})
