vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		require("copilot").setup({
			suggestion = {
				enabled = false,
				keymap = {
					accept = "<Tab>",
					next = "<S-Tab>",
				},
			},
			panel = { enabled = false },
			filetypes = {
				javascript = true,
				typescript = true,
				typescriptreact = true,
				javascriptreact = true,
				python = true,
				["*"] = false,
			},
		})
	end,
})
