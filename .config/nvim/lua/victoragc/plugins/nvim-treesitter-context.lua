---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'nvim-treesitter/nvim-treesitter-context',
		lazy = false,
		opts = {
			min_window_height = 36,
			max_lines = 6,
			multiline_threshold = 2,
			trim_scope = 'outer',
		},
		keys = {
			{
				'<leader>tc',
				function()
					require('treesitter-context').toggle()
				end,
				desc = '[T]oggle treesitter [c]ontext',
			},
			{
				'[c',
				function()
					require('treesitter-context').go_to_context(vim.v.count1)
				end,
				desc = 'Go up [c]ontext',
			},
		},
	},
}

return plugins
