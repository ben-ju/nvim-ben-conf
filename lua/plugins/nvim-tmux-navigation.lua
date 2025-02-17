return {
	"alexghergh/nvim-tmux-navigation",
	config = function()
		require("nvim-tmux-navigation").setup({})
		vim.keymap.set("n", "<C-H>", "<Cmd>NvimTmuxNavigateLeft<CR>", {})
		vim.keymap.set("n", "<C-J>", "<Cmd>NvimTmuxNavigateDown<CR>", {})
		vim.keymap.set("n", "<C-K>", "<Cmd>NvimTmuxNavigateUp<CR>", {})
		vim.keymap.set("n", "<C-L>", "<Cmd>NvimTmuxNavigateRight<CR>", {})
	end,
}
