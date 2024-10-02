vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Remove ~ in end of buffer
vim.o.fillchars = "eob: "

-- Set termguicolors to enable highlight groups
vim.o.termguicolors = true

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Set default tab stop
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- Set scrolloffset
vim.o.scrolloff = 999

vim.opt.cmdheight = 0
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Show list chars
vim.opt.list = true
vim.opt.listchars = { tab = "⊣ ", trail = "∙", nbsp = "␣", multispace = "∙" }

-- Set cursor to block
vim.opt.guicursor = {
	"n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon0-blinkoff0",
	"i-ci:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
	"r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100",
}

vim.filetype.add({
	extension = {
		mdx = "markdown.mdx",
	},
	filename = {},
	pattern = {},
})

-- Autocmds
-- Highlight on Yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on Yank",
	group = vim.api.nvim_create_augroup("nvim-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- MasonToolInstaller
vim.api.nvim_create_autocmd("User", {
	pattern = "MasonToolsStartingInstall",
	callback = function()
		vim.schedule(function()
			print("mason-tool-installer is starting")
		end)
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MasonToolsUpdateCompleted",
	callback = function(e)
		vim.schedule(function()
			print(vim.inspect(e.data)) -- print the table that lists the programs that were installed
		end)
	end,
})
