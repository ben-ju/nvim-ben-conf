return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},

	init = function()
		vim.g.barbar_auto_setup = false
		vim.opt.hidden = true -- Ensure buffers can be hidden
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
		map("n", "<A-x>", "<Cmd>BufferClose<CR>", { desc = "Close current tab" }) -- close current tab
		map("n", "<A-n>", "<Cmd>BufferNext<CR>", { desc = "Go to next tab" }) --  go to next tab
		map("n", "<A-p>", "<Cmd>BufferPrevious<CR>", { desc = "Go to previous tab" }) --  go to previous tab
		map("n", "<A-ù>", "<Cmd>vsplit<CR>", { desc = "Split the current buffer" }) -- Split the current buffer on the right

		-- TODO : remove this from the which key
		map("n", "<A-a>", "<Cmd>BufferGoto 1<CR>", opts)
		map("n", "<A-z>", "<Cmd>BufferGoto 2<CR>", opts)
		map("n", "<A-e>", "<Cmd>BufferGoto 3<CR>", opts)
		map("n", "<A-r>", "<Cmd>BufferGoto 4<CR>", opts)
		map("n", "<A-t>", "<Cmd>BufferGoto 5<CR>", opts)
		map("n", "<A-y>", "<Cmd>BufferGoto 6<CR>", opts)
		map("n", "<A-u>", "<Cmd>BufferGoto 7<CR>", opts)
		map("n", "<A-i>", "<Cmd>BufferGoto 8<CR>", opts)
		map("n", "<A-o>", "<Cmd>BufferGoto 9<CR>", opts)
	end,
}
