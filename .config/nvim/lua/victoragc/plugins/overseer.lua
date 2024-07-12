---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'stevearc/overseer.nvim',
		dependencies = { 'nvim-telescope/telescope.nvim' },
		opts = {},
		keys = {
			{
				'<leader>xt',
				'<Cmd>OverseerRun<CR>',
				desc = 'E[x]ecute [t]ask',
			},
			{
				'<leader>tt',
				'<Cmd>OverseerToggle<CR>',
				desc = '[T]oggle [t]asklist',
			},
		},
	},
}

return plugins
