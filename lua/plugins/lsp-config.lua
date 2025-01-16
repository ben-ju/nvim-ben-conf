return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"j-hui/fidget.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- setup fidget
		require("fidget").setup({})

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "cR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "cd", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "cD", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "ci", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "ct", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>cB", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>cd", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "<C-p>", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "<C-n>", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "ck", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()
		-- local capabilities = require("blink.cmp").get_lsp_capabilities()
		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
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
									"vendor/laravel/framework/src",
									"vendor/spatie/laravel-permission/src",
									"vendor/laravel/sanctum/src",
									"vendor/inertiajs/inertia-laravel/src",
									"vendor/fakerphp/faker/src",
									"vendor/typesense/typesense-php/src",
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
						-- Désactiver le formatage par tsserver (préférence pour Prettier)
						client.server_capabilities.documentFormattingProvider = false
						-- Keymaps spécifiques à TypeScript/React
						local ts_opts = { buffer = bufnr, silent = true }
						keymap.set("n", "<leader>oi", "<cmd>TypescriptOrganizeImports<CR>", ts_opts)
						keymap.set("n", "<leader>rf", "<cmd>TypescriptRenameFile<CR>", ts_opts)
					end,
				})
			end,
		})
	end,
}
