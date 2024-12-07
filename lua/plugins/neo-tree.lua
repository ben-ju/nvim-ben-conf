return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({ default_mappings = false })
		vim.keymap.set("n", "<leader>²", ":Neotree filesystem reveal current<CR>", { desc = "Open folder tree" })
	end,
}
