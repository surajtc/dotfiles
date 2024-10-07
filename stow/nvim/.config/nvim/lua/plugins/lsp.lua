-- config for LSP and completion
return {
	"neovim/nvim-lspconfig",
	cmd = { "LspInfo", "LspInstall", "LspStart" },
	event = { "BufReadPre", "BufNewFile" },

	dependencies = {
		{
			"VonHeikemen/lsp-zero.nvim",
			branch = "v4.x",
			lazy = true,
			config = false,
		},
		{
			"williamboman/mason.nvim",
			lazy = false,
			config = true,
		},
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "L3MON4D3/LuaSnip" },
				{ "rafamadriz/friendly-snippets" },
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-path" },
				{ "hrsh7th/cmp-cmdline" },
				{ "saadparwaiz1/cmp_luasnip" },
			},
			config = function()
				local cmp = require("cmp")

				cmp.setup({
					sources = {
						{ name = "nvim_lsp" },
						{ name = "luasnip", keyword_length = 2 },
						{ name = "buffer", keyword_length = 3 },
						{ name = "path" },
					},
					mapping = cmp.mapping.preset.insert({
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-u>"] = cmp.mapping.scroll_docs(-4),
						["<C-d>"] = cmp.mapping.scroll_docs(4),
					}),
					snippet = {
						expand = function(args)
							vim.snippet.expand(args.body)
						end,
					},
				})
			end,
		},
	},
	config = function()
		local lsp_zero = require("lsp-zero")

		-- lsp_attach is where you enable features that only work
		-- if there is a language server active in the file
		local lsp_attach = function(_, bufnr)
			local opts = { buffer = bufnr, remap = false }

			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, vim.tbl_deep_extend("force", opts, { desc = "LSP Hover" }))
			vim.keymap.set("n", "gr", function()
				vim.lsp.buf.references()
			end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Reference" }))
			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition" }))
		end
		--     vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>',
		--                    opts)
		--     vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>',
		--                    opts)
		--     vim.keymap.set('n', 'gi',
		--                    '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		--     vim.keymap.set('n', 'go',
		--                    '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		--     vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>',
		--                    opts)
		--     vim.keymap.set('n', 'gs',
		--                    '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		--     vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>',
		--                    opts)
		--     vim.keymap.set({'n', 'x'}, '<F3>',
		--                    '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
		--                    opts)
		--     vim.keymap.set('n', '<F4>',
		--                    '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
		-- end

		lsp_zero.extend_lspconfig({
			sign_text = true,
			lsp_attach = lsp_attach,
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		require("mason").setup()

		local ensure_installed = {
			"lua_ls",
			"stylua",
			"pylsp",
			"isort",
			"black",
			"ts_ls",
			"eslint",
			"html",
			"cssls",
			"prettierd",
			"prettier",
		}

		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
			run_on_start = true,
			auto_update = true,
		})

		require("mason-lspconfig").setup({
			handlers = {
				-- this first function is the "default handler"
				-- it applies to every language server without a "custom handler"
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			},
		})
	end,
}
