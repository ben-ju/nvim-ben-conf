return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")
		-- local mason_dap = require("mason-nvim-dap")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			automatic_installation = true,
			-- list of servers for mason to install
			ensure_installed = {
				"ts_ls",
				"intelephense",
				"html",
				"cssls",
				"tailwindcss",
				"sqlls",
				"lua_ls",
				"jsonls",
				"dotls",
				"docker_compose_language_service",
				"dockerls",
				"pyright",
				"gopls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettierd", -- prettier formatter
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"black",
				"gofumpt",
				"goimports",
				"sql-formatter",
				"php-cs-fixer",
				"staticcheck",
				-- Go tools
				"gofumpt", -- Strict Go formatter
				"goimports", -- Manages imports
				"golines", -- Wraps long lines
				"gomodifytags", -- Struct tag manipulation
				"impl", -- Method stub generator
				"gotests", -- Test generator
				"staticcheck", -- Advanced linting
				"delve", -- Debugger (DAP)
			},
		})
		-- mason_dap.setup({
		-- 	ensure_installed = { "delve" },
		-- 	automatic_installation = true,
		-- })
	end,
}
