return {
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		-- branch = "develop", -- if you want develop branch
		-- keep in mind, it might break everything
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
		},
		config = function()
			require("gopher").setup({})

			-- Define keybindings for gopher.nvim commands
			local keymap = vim.keymap

			-- Map <leader>csj to :GoTagAdd json
			keymap.set(
				"n",
				"<leader>csj",
				":GoTagAdd json<CR>",
				{ noremap = true, silent = true, desc = "Add JSON tag" }
			)

			-- Map <leader>csy to :GoTagAdd yaml
			keymap.set(
				"n",
				"<leader>csy",
				":GoTagAdd yaml<CR>",
				{ noremap = true, silent = true, desc = "Add YAML tag" }
			)

			-- Map <leader>csr to :GoTagRm
			keymap.set("n", "<leader>csr", ":GoTagRm<CR>", { noremap = true, silent = true, desc = "Remove tag" })
		end,
	},
}
