local keymap = vim.keymap

-- Tab related keys
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
-- En mode normal, en appuyant sur <Enter>, insère une ligne et revient en mode normal
vim.keymap.set("n", "<CR><CR>", "o<Esc>", { noremap = true, silent = true })
vim.keymap.set("v", "<", "<gv", { desc = "Avoid exiting visual mode while trying to indent" })
vim.keymap.set("v", ">", ">gv", { desc = "Avoid exiting visual mode while trying to indent" })

vim.keymap.set({ "v", "n" }, "<C-o>", "<C-o>zz", { desc = "Moving to previous position and center" })
vim.keymap.set({ "v", "n" }, "<C-i>", "<C-i>zz", { desc = "Moving to new position and center" })
-- navigate vim pane
-- vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
-- vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
-- vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
-- vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
-- Crée un autocmd pour détecter les collages
vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		-- Vérifie si le dernier événement est un collage
		if vim.v.event.operator == "p" or vim.v.event.operator == "P" then
			-- Supprime les retours chariot (\r)
			pcall(function()
				vim.cmd([[%s/\r//g]])
			end)
		end
	end,
})
