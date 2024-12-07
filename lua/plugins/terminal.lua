return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup()
		vim.keymap.set({ "n", "v", "t" }, "<C-t>", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true })
	end,
	opts = {--[[ things you want to change go here]]
	},
}
