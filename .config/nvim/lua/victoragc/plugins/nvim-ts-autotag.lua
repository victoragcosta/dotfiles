---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'windwp/nvim-ts-autotag',
		event = 'VimEnter',
		opts = {
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = true,
			},
			per_filetype = {
				['html'] = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = true,
				},
			},
		},
	},
}

return plugins
