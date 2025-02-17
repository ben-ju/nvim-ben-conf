-- TODO Change this public
return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.move").setup()
		require("mini.trailspace").setup()

		-- Remove trailing spaces when leaving insert mode, but handle errors gracefully
		vim.api.nvim_create_autocmd("InsertLeave", {
			callback = function()
				local ok, err = pcall(function()
					MiniTrailspace.trim()
				end)
				if not ok then
					return
				end
			end,
		})
	end,
}
