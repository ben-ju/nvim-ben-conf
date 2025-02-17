return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"j-hui/fidget.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local util = require("lspconfig/util")

		require("fidget").setup({})

		local keymap = vim.keymap
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				keymap.set("n", "cR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "cd", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "cD", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "ci", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "ct", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>cB", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>cd", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "<C-p>", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "<C-n>", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "ck", vim.lsp.buf.hover, opts)
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			-- handler par défaut
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,

			["intelephense"] = function()
				lspconfig.intelephense.setup({
					capabilities = capabilities,
					settings = {
						intelephense = {
							licenseKey = "009PSYLBDG3DBWA",
							files = {
								maxSize = 5000000, -- Support des fichiers volumineux
							},
							stubs = {
								"bcmath",
								"bz2",
								"Core",
								"curl",
								"date",
								"dom",
								"fileinfo",
								"filter",
								"hash",
								"json",
								"libxml",
								"mbstring",
								"mysql",
								"openssl",
								"pcre",
								"PDO",
								"pdo_mysql",
								"Phar",
								"readline",
								"Reflection",
								"session",
								"SimpleXML",
								"soap",
								"sodium",
								"SPL",
								"standard",
								"tokenizer",
								"xml",
								"xmlreader",
								"xmlwriter",
								"zip",
								"zlib",
								"laravel",
							},
							environment = {
								includePaths = {
									-- "vendor/laravel/framework/src",
									-- "vendor/spatie/laravel-permission/src",
									-- "vendor/laravel/sanctum/src",
									-- "vendor/inertiajs/inertia-laravel/src",
									-- "vendor/fakerphp/faker/src",
									"vendor",
									-- "vendor/typesense/typesense-php/src",
								},
							},
							diagnostics = {
								enable = true,
							},
						},
					},
				})
			end,

			["ts_ls"] = function()
				lspconfig.ts_ls.setup({
					capabilities = capabilities,
					root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
					settings = {
						typescript = {
							preferences = {
								importModuleSpecifier = "relative",
								jsxAttributeCompletionStyle = "braces",
							},
						},
						javascript = {
							preferences = {
								importModuleSpecifier = "relative",
							},
						},
					},
					environment = {
						includePaths = {
							"node_modules",
							"node_modules/@types",
							"resources/js",
						},
					},
					on_attach = function(client, bufnr)
						client.server_capabilities.documentFormattingProvider = false
						local ts_opts = { buffer = bufnr, silent = true }
						keymap.set("n", "<leader>oi", "<cmd>TypescriptOrganizeImports<CR>", ts_opts)
						keymap.set("n", "<leader>rf", "<cmd>TypescriptRenameFile<CR>", ts_opts)
					end,
				})
			end,

			["sqls"] = function()
				lspconfig.sqls.setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						-- Si tu souhaites gérer le formatage auto dans tes fichiers SQL
						client.server_capabilities.documentFormattingProvider = true

						-- Exemple de keymap local au buffer SQL
						local sql_opts = { buffer = bufnr, silent = true }
						keymap.set("n", "<leader>cf", function()
							vim.lsp.buf.format({ async = true })
						end, sql_opts)
					end,
					settings = {
						sqls = {
							connections = {
								-- {
								-- 	driver = "postgres",
								-- 	dataSourceName = "host=localhost port=5432 user=postgres password=postgres dbname=mydb sslmode=disable",
								-- },
								-- Exemple MySQL/MariaDB
								-- {
								--   driver = "mysql",
								--   dataSourceName = "root:root@tcp(127.0.0.1:3306)/test",
								-- },
							},
						},
					},
				})
			end,
			["gopls"] = function()
				lspconfig.gopls.setup({
					-- Inherit default LSP capabilities from cmp_nvim_lsp
					capabilities = capabilities,

					-- Command to start the gopls server with specific subcommand
					cmd = { "gopls", "serve" }, -- 'serve' enables long-running server mode

					-- File types that trigger this LSP
					filetypes = { "go", "gomod", "gowork", "gotmpl" }, -- Covers Go and module files

					-- How to find project root (important for module-aware mode)
					root_dir = util.root_pattern("go.work", "go.mod", ".git"), -- Standard Go project markers

					settings = {
						gopls = {
							-- Code analysis configurations
							analyses = {
								unusedparams = true, -- Warn about unused function parameters
								shadow = true, -- Detect variable shadowing issues
							},

							-- Enable advanced static checking
							staticcheck = true, -- Use Staticcheck linter
							gofumpt = true, -- Enforce stricter formatting rules

							-- Inlay hints configuration (type hints, parameter names, etc)
							hints = {
								assignVariableTypes = true, -- Show inferred types for variables
								compositeLiteralFields = true, -- Show field names in struct literals
								constantValues = true, -- Show constant values
								functionTypeParameters = true, -- Show generic type parameters
								parameterNames = true, -- Show parameter names in calls
								rangeVariableTypes = true, -- Show loop variable types
							},

							-- Enhanced syntax highlighting
							semanticTokens = true, -- Enable semantic token support

							-- Build flags for conditional compilation
							buildFlags = { "-tags=integration,e2e" }, -- Custom build tags
						},
					},

					-- Called when LSP attaches to a buffer
					on_attach = function(client, bufnr)
						-- Set up auto-formatting before saving Go files
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr, -- Only for this buffer
							callback = function()
								-- Synchronous formatting to ensure completion before save
								vim.lsp.buf.format({ async = false })
							end,
						})
					end,
				})
			end,
		})
	end,
}
