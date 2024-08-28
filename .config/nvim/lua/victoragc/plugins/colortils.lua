---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'max397574/colortils.nvim',
		opts = {
			default_format = 'hsl',
			mappings = {
				set_register_default_format = 'd<CR>',
				set_register_choose_format = '<CR>',
				replace_default_format = 'd<C-CR>',
				replace_choose_format = '<C-CR>',
			},
		},
		keys = {
			{ '<leader>xcp', '<Cmd>Colortils picker<CR>', desc = '[P]ick a [c]olor' },
			{
				'<leader>xcl',
				'<Cmd>Colortils lighten<CR>',
				desc = '[L]ighten a [c]olor',
			},
			{
				'<leader>xcd',
				'<Cmd>Colortils darken<CR>',
				desc = '[D]arken a [c]olor',
			},
			{
				'<leader>xcg',
				'<Cmd>Colortils greyscale<CR>',
				desc = '[G]reyscale a [c]olor',
			},
			{
				'<leader>xcc',
				'<Cmd>Colortils css list<CR>',
				desc = '[C]hoose a CSS [c]olor',
			},
		},
	},
}

return plugins
