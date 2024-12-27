return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},

		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						luasnip.lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-n>"] = cmp.mapping.select_next_item(), -- Descendre
					["<C-p>"] = cmp.mapping.select_prev_item(), -- Monter
					["<C-e>"] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
	-- 	{
	-- 		"saghen/blink.cmp",
	-- 		dependencies = {
	-- 			"rafamadriz/friendly-snippets",
	-- 			{ "L3MON4D3/LuaSnip", version = "v2.*" },
	-- 		},
	-- 		-- use a release tag to download pre-built binaries
	-- 		version = "v0.*",
	-- 		opts = {
	-- 			snippets = {
	-- 				expand = function(snippet)
	-- 					require("luasnip").lsp_expand(snippet)
	-- 				end,
	-- 				active = function(filter)
	-- 					if filter and filter.direction then
	-- 						return require("luasnip").jumpable(filter.direction)
	-- 					end
	-- 					return require("luasnip").in_snippet()
	-- 				end,
	-- 				jump = function(direction)
	-- 					require("luasnip").jump(direction)
	-- 				end,
	-- 			},
	-- 			keymap = { preset = "default" },
	-- 			appearance = {
	-- 				use_nvim_cmp_as_default = true,
	-- 				nerd_font_variant = "mono",
	-- 			},
	-- 			signature = { enable = true },
	-- 		},
	-- 	},
}
