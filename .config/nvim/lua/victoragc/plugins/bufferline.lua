---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'akinsho/bufferline.nvim',
		version = '*',
		config = function()
			require('bufferline').setup()
		end,
	},
}

return plugins
