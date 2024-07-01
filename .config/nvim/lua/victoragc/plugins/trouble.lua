---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'folke/trouble.nvim',
		opts = {
			warn_no_results = false,
			open_no_results = true,
		},
		cmd = 'Trouble',
		keys = {
			{
				'<leader>q',
				'<Cmd>Trouble diagnostics toggle<CR>',
				desc = '[T]oggle diagnostics (Trouble  x)',
			},
			{
				'<leader>dq',
				'<Cmd>Trouble diagnostics toggle filter.buf=0<CR>',
				desc = '[D]ocument Diagnostics (Trouble  x)',
			},
			{
				'<leader>ds',
				'<Cmd>Trouble symbols toggle focus=false<CR>',
				desc = '[D]ocument [s]ymbols (Trouble)',
			},
			{
				'<leader>tl',
				'<Cmd>Trouble lsp toggle focus=false win.position=right<CR>',
				desc = '[T]oggle [L]SP Definitions / references / ... (Trouble)',
			},
		},
	},
}

return plugins
