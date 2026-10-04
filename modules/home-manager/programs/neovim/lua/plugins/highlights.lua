local colors = require("mini.base16").config.palette

-- These overrides intentionally run after the other plugin configurations.
vim.api.nvim_set_hl(0, "MsgArea", { fg = colors.base03 })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.base03 })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.base0D })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.base07, bg = colors.base01 })
vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.base00 })
vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = colors.base01 })
vim.api.nvim_set_hl(0, "SnacksIndent", { fg = colors.base02 })
vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = colors.base03 })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.base0D })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.base00 })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = colors.base0D })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = colors.base0D })
