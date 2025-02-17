return {
	"folke/which-key.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
		local wk = require("which-key")
		wk.setup({
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				-- the presets plugin, adds help for a bunch of default keybindings in Neovim
				-- No actual key bindings are created
				spelling = {
					enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
					suggestions = 20, -- how many suggestions should be shown in the list?
				},
				presets = {
					operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
					motions = false, -- adds help for motions text_objects = false, -- help for text objects triggered after entering an operator
					windows = false, -- default bindings on <c-w>
					nav = false, -- misc bindings to work with windows
					z = false, -- bindings for folds, spelling and others prefixed with z
					g = false, -- bindings for prefixed with g
				},
			},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and it's label
				group = "+", -- symbol prepended to a group
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 4, -- spacing between columns
				align = "left", -- align columns left, center or right
			},
			show_help = true, -- show help message on the command line when the popup is visible
		})
		-- wk.add({
		-- 	{ "<leader>?", desc = "Which key ?" },
		-- })
		wk.add({
			{ "<leader>g", group = "LSP", mode = { "n", "v" } },
		})
		wk.add({
			{ "<leader>d", desc = "debugger", mode = { "n", "v" } },
		})

		wk.add({
			{ "<leader>$", group = "git", mode = { "n", "v" } },
		})
		wk.add({
			{ "<leader>cs", group = "[GO]struct", mode = { "n", "v" } },
		})
		wk.add({
			{ "<leader>c", group = "code", mode = { "n" } },
		})
		wk.add({
			{ "<leader>x", group = "diagnostics", mode = { "n", "v" } },
		})
		wk.add({
			{ "<leader>f", group = "find", mode = { "n", "v" } },
		})
		wk.add({
			{ "<leader>w", group = "workspace", mode = { "n", "v" } },
		})
		wk.add({
			{ "<leader>m", group = "menu", mode = { "n", "v" } },
		})
		wk.add({
			{ "<leader>t", group = "tab", mode = { "n", "v" } },
		})
	end,
	-- keys = {
	-- 	{
	-- 		"<leader>?",
	-- 		function()
	-- 			wk.show({ global = false })
	-- 		end,
	-- 		desc = "Buffer Local Keymaps (which-key)",
	-- 	},
	-- 	{
	-- 		"<leader>g",
	-- 	},
	-- },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
}
