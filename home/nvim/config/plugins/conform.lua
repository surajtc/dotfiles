require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier" },
		scss = { "prettierd", "prettier" },
		less = { "prettierd", "prettier" },
		html = { "prettierd", "prettier" },
		svg = { "prettierd", "prettier" },
		xml = { "prettierd", "prettier" },
		json = { "prettierd", "prettier" },
		jsonc = { "prettierd", "prettier" },
		yaml = { "prettierd", "prettier" },
		markdown = { "prettierd", "prettier" },
		["markdown.mdx"] = { "prettierd", "prettier" },
		nix = { "alejandra" },
	},

	formatters = {
		stylua = {
			-- prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
		},
	},
})
