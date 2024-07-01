---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'nvim-treesitter/nvim-treesitter-context',
		lazy = false,
		opts = {},
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
