---@type ( string | LazyPluginSpec )[]
local plugins = {
	{
		'akinsho/git-conflict.nvim',
		cond = not vim.g.started_by_firenvim,
		lazy = false,
		opts = {},
		config = true,
		keys = {
			{
				'<leader>HQ',
				'<cmd>GitConflictListQf<cr>',
				desc = 'git set [Q]uickfix list for repo',
			},
		},
	},
}

return plugins
