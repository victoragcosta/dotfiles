---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'olrtg/nvim-emmet',
		keys = function()
			return {
				{
					'<leader>xe',
					require('nvim-emmet').wrap_with_abbreviation,
					mode = 'n',
					desc = 'Wrap with [e]mmet abbreviation',
				},
				{
					'<leader>xe',
					require('nvim-emmet').wrap_with_abbreviation,
					mode = 'v',
					desc = 'Wrap with [e]mmet abbreviation',
				},
			}
		end,
	},
}

return plugins
