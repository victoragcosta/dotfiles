---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'ggandor/leap.nvim',
		keys = {
			{
				's',
				'<Plug>(leap-forward)',
				mode = { 'n', 'x', 'o' },
				desc = '[s]alta pra frente',
			},
			{
				'S',
				'<Plug>(leap-backward)',
				mode = { 'n', 'x', 'o' },
				desc = '[S]alta pra trás',
			},
			{
				'gs',
				'<Plug>(leap-from-window)',
				mode = { 'n', 'x', 'o' },
				desc = '[s]alta pela janela',
			},
		},
	},
}

return plugins
