return {
	{
		"mfussenegger/nvim-dap",
		ft = { "go", "gomod" },
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"nvim-neotest/nvim-nio",
		},

		config = function()
			local dap, dapui = require("dap"), require("dapui")

			require("dapui").setup()
			require("dap-go").setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- vim.keymap.set("n", "<Leader>dt", ":DapUiToggle<CR>", { desc = "Toggle DAP UI" })
			-- vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Breakpoint" })
			-- vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue" })
			-- vim.keymap.set("n", "<Leader>dr", ":lua require('dapui').open({reset = true})<CR>", { desc = "Reset" })

			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "⏺", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
		end,
	},
}
