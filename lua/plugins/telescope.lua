return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Telescope find word under cursor" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

			-- Configuration principale de Telescope
			require("telescope").setup({
				defaults = {
					-- Inclure les fichiers cachés et ignorer le .gitignore
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--no-ignore", -- Ne pas respecter le .gitignore
						"--hidden", -- Inclure les fichiers cachés comme .env
					},
					-- Exclure les dossiers indésirables
					file_ignore_patterns = { "node_modules/", ".git/", "vendor/", "dist/" },
					-- Mappings personnalisés
					mappings = {
						i = {
							["<C-n>"] = require("telescope.actions").move_selection_next,
							["<C-p>"] = require("telescope.actions").move_selection_previous,
						},
						n = {
							["<C-n>"] = require("telescope.actions").move_selection_next,
							["<C-p>"] = require("telescope.actions").move_selection_previous,
						},
					},
				},
				pickers = {
					-- Configuration spécifique pour `find_files`
					find_files = {
						-- Utiliser ripgrep pour inclure les fichiers cachés et ignorer le .gitignore
						find_command = { "rg", "--files", "--no-ignore", "--hidden" },
					},
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	},
}
