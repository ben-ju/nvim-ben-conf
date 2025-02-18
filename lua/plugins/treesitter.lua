return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects" }, -- syntax aware text objects
		{
			-- show code context
			"nvim-treesitter/nvim-treesitter-context",
			opts = { enable = true, mode = "topline" },
		},
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local config = require("nvim-treesitter.configs")
		local autotag = require("nvim-ts-autotag")
		vim.api.nvim_create_autocmd("Filetype", {
			pattern = { "markdown" },
			callback = function(ev)
				-- context is buggy with markdown
				require("treesitter-context").disable()
			end,
		})
		autotag.setup({
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = true,
			},
		})

		config.setup({
			ensure_installed = {
				"lua",
				"javascript",
				"go",
				"html",
				"php",
				"typescript",
				"phpdoc",
				"json",
				"yaml",
				"css",
				"bash",
				"vim",
				"dockerfile",
				"gitignore",
				"sql",
				"xml",
				"vue",
				"bash",
				"luadoc",
				"nginx",
				"python",
				"regex",
				"scss",
				"tmux",
				"tsx",
				"jsdoc",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			sync_install = false,
			auto_install = true,
			text_objects = { select = { enable = true, lookahead = true } },
			highlight = { enable = true },
			indent = { enable = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["ap"] = "@parameter.outer",
						["ip"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
						["]P"] = "@parameter.inner",
					},
					goto_next_end = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]p"] = "@parameter.inner",
					},
					goto_previous_start = {

						["@F"] = "@function.outer",
						["@C"] = "@class.outer",
						["@P"] = "@parameter.inner",
					},
					goto_previous_end = {
						["@f"] = "@function.outer",
						["@c"] = "@class.outer",
						["@p"] = "@parameter.inner",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["spn"] = "@parameter.inner",
					},
					swap_previous = {
						["spp"] = "@parameter.inner",
					},
				},
			},
		})
	end,
}
