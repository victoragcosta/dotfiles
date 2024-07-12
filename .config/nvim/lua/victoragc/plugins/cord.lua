---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'vyfor/cord.nvim',
		enabled = false,
		build = './build',
		event = 'VeryLazy',
		opts = {
			log_level = 'debug',
		},
	},
}

return plugins
