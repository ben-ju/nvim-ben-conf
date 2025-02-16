return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local config = require("nvim-treesitter.configs")
		local autotag = require("nvim-ts-autotag")
		autotag.setup({
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = true,
			},
		})

		config.setup({
			ensure_installed = {
				"lua",
				"javascript",
				"go",
				"html",
				"php",
				"typescript",
				"phpdoc",
				"json",
				"yaml",
				"css",
				"bash",
				"vim",
				"dockerfile",
				"gitignore",
				"sql",
				"xml",
				"vue",
				"bash",
				"luadoc",
				"nginx",
				"python",
				"regex",
				"scss",
				"tmux",
				"tsx",
				"jsdoc",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
