---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'sindrets/diffview.nvim',
		opts = {
			view = {
				merge_tool = {
					layout = 'diff3_mixed',
				},
			},
		},
	},
}

return plugins
