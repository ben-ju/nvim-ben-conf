return {
	"hek14/symbol-overlay.nvim",
	event = "BufRead",
	config = function()
		local symbol = require("symbol-overlay")
		symbol.setup({
			-- keymap = {
			-- 	toggle = "",
			-- 	clear_all = "",
			-- },
		})
		require("telescope").load_extension("symbol_overlay") -- comment this if you don't have telescope installed
		-- Manually define keybindings with descriptions
		local keymap = vim.keymap

		-- Map <leader>ch to toggle symbol overlay
		keymap.set("n", "<leader>ch", symbol.toggle, { noremap = true, silent = true, desc = "Toggle Highlight" })

		-- Map <leader>cc to clear all symbols
		keymap.set("n", "<leader>cc", symbol.clear_all, { noremap = true, silent = true, desc = "Clear Hightlights" })
	end,
}
