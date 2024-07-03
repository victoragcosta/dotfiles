---@type (string| LazyPluginSpec)[]
local plugins = {
	{
		'mfussenegger/nvim-dap',
		-- NOTE: Disable debuggers for textarea editors in the browser (it makes no sense using them)
		cond = not vim.g.started_by_firenvim,
		dependencies = {
			-- Creates a beautiful debugger UI
			'rcarriga/nvim-dap-ui',

			-- Required dependency for nvim-dap-ui
			'nvim-neotest/nvim-nio',

			-- Add virtual text
			'theHamsta/nvim-dap-virtual-text',

			-- Daps
			'mxsdev/nvim-dap-vscode-js',
		},
		config = function()
			local dap = require 'dap'
			local dapui = require 'dapui'

			-- Basic debugging keymaps, feel free to change to your liking!
			vim.keymap.set(
				'n',
				'<F5>',
				dap.continue,
				{ desc = 'Debug: Start/Continue' }
			)
			vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
			vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
			vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
			vim.keymap.set(
				'n',
				'<leader>b',
				dap.toggle_breakpoint,
				{ desc = 'Debug: Toggle Breakpoint' }
			)
			vim.keymap.set('n', '<leader>B', function()
				dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
			end, { desc = 'Debug: Set Breakpoint' })

			-- Dap UI setup
			-- For more information, see |:help nvim-dap-ui|
			---@diagnostic disable-next-line: missing-fields
			dapui.setup {}

			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
			vim.keymap.set(
				'n',
				'<F7>',
				dapui.toggle,
				{ desc = 'Debug: See last session result.' }
			)

			dap.listeners.after.event_initialized['dapui_config'] = dapui.open
			dap.listeners.before.event_terminated['dapui_config'] = dapui.close
			dap.listeners.before.event_exited['dapui_config'] = dapui.close
		end,
	},
}
return plugins
