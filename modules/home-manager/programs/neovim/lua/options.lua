vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.fillchars = "eob: "
vim.o.termguicolors = true
vim.o.winborder = "rounded"
vim.o.hlsearch = false
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = "yes"
vim.o.cursorline = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect"
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.scrolloff = 4
vim.o.showtabline = 0
vim.o.smartindent = true

vim.opt.guicursor = {
	"n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon0-blinkoff100",
	"i-ci:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
	"r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100",
}

vim.opt.list = true
vim.opt.listchars = { tab = "⊣ ", trail = "∙", nbsp = "␣" }

vim.filetype.add({
	extension = { mdx = "markdown.mdx" },
	filename = {},
	pattern = {},
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on Yank",
	group = vim.api.nvim_create_augroup("nvim-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
