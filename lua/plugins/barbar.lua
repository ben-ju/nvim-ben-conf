return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},

	init = function()
		vim.g.barbar_auto_setup = false
	end,
	opts = {
		-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
		-- animation = true,
		-- insert_at_start = true,
		-- …etc.
	},
	version = "^1.0.0", -- optional: only update when a new 1.x version is released
	config = function()
		-- import comment plugin safely
		local barbar = require("barbar")

		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		-- enable comment
		barbar.setup({
			-- for commenting tsx, jsx, svelte, html files
			pre_hook = ts_context_commentstring.create_pre_hook(),
			clickable = true, -- Enables/disables clickable tabs
			tabpages = false, -- Enable/disables current/total tabpages indicator (top right corner)
			insert_at_end = true,
			icons = {
				button = "",
				buffer_index = true,
				filetype = { enabled = true },
				visible = { modified = { buffer_number = false } },
				gitsigns = {
					added = { enabled = true, icon = "+" },
					changed = { enabled = true, icon = "~" },
					deleted = { enabled = true, icon = "-" },
				},
			},
		})
		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		-- Goto buffer in position...
		--
		-- local keymap = vim.keymap

		-- Tab related keys
		-- map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
		map("n", "<leader>tx", "<Cmd>BufferClose<CR>", { desc = "Close current tab" }) -- close current tab
		map("n", "<leader>tn", "<Cmd>BufferMoveNext<CR>", { desc = "Go to next tab" }) --  go to next tab
		map("n", "<leader>tp", "<Cmd>BufferMovePrevious<CR>", { desc = "Go to previous tab" }) --  go to previous tab
		map("n", "<leader>to", "<Cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
		map("n", "<leader>ta", "<Cmd>BufferGoto 1<CR>", opts)
		map("n", "<leader>tz", "<Cmd>BufferGoto 2<CR>", opts)
		map("n", "<leader>te", "<Cmd>BufferGoto 3<CR>", opts)
		map("n", "<leader>tr", "<Cmd>BufferGoto 4<CR>", opts)
		map("n", "<leader>tt", "<Cmd>BufferGoto 5<CR>", opts)
		map("n", "<leader>ty", "<Cmd>BufferGoto 6<CR>", opts)
		map("n", "<leader>tu", "<Cmd>BufferGoto 7<CR>", opts)
		map("n", "<leader>ti", "<Cmd>BufferGoto 8<CR>", opts)
	end,
}
