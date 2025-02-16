return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {},
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				-- You can customize some of the format options for the filetype (:help conform.format)
				-- Conform will run the first available formatter
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier" },
				javascriptreact = { "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				html = { "prettierd", "prettier" },
				json = { "prettierd", "prettier" },
				yaml = { "prettierd", "prettier" },
				graphql = { "prettierd", "prettier" },
				go = { "gofumpt", "goimports" },
			},
			format_on_save = {
				-- if no formatter has been found, it will try to use lsp to format
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},
			vim.keymap.set({ "n", "v" }, "<leader>cf", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end, { desc = "Format file" }),
		})
	end,
}
