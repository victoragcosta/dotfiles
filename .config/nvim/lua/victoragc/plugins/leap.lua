---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'ggandor/leap.nvim',
		keys = {
			{
				'S',
				'<Plug>(leap-forward)',
				mode = { 'n', 'x', 'o' },
				desc = '[S]alta pra frente',
			},
			{
				'gs',
				'<Plug>(leap-backward)',
				mode = { 'n', 'x', 'o' },
				desc = '[s]alta pra trás',
			},
			{
				'gS',
				'<Plug>(leap-from-window)',
				mode = { 'n', 'x', 'o' },
				desc = '[S]alta pela janela',
			},
		},
	},
}

return plugins
