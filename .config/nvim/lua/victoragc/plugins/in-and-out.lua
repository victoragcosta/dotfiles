---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'ysmb-wtsg/in-and-out.nvim',
		keys = {
			{
				'<M-i>',
				function()
					require('in-and-out').in_and_out()
				end,
				mode = 'i',
				desc = 'Move out of punctuation pairs with [i]n and out',
			},
		},
	},
}

return plugins
