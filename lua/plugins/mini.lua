return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.move").setup()
		require("mini.trailspace").setup()
		-- Remove when leave insertion mode trailspaces
		vim.api.nvim_create_autocmd("InsertLeave", {
			callback = function()
				MiniTrailspace.trim()
			end,
		})
	end,
}
