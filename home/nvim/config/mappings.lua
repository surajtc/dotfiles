-- Telescope
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind [W]ord under cursor" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind [G]rep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })

vim.keymap.set("n", "<leader>f/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[F]ind [/] in Open Files" })

vim.keymap.set({ "n", "v" }, "<leader>ft", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "[F]orma[T] File" })

vim.keymap.set("n", "<leader>ee", function()
	require("oil").toggle_float()
end, { desc = "Toggle Oil" })

-- Buffer
vim.keymap.set("n", "<leader>h", "<cmd>bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>l", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>b", "<cmd>b#<CR>", { desc = "Alt buffer" })
vim.keymap.set("n", "<leader>w", function()
	require("snacks").bufdelete.delete()
end, { desc = "[B]uffer Delete" })
vim.keymap.set("n", "<leader>ww", function()
	require("snacks").bufdelete.all()
end, { desc = "[B]uffer Delete" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
