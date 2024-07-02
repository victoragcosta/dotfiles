---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'ziontee113/color-picker.nvim',
		opts = {
			icons = { '󰝤', '󱡔' },
		},
		keys = {
			{ '<leader>xc', '<Cmd>PickColor<CR>', desc = 'Pick a [c]olor' },
			{
				'<C-c>',
				'<Cmd>PickColorInsert<CR>',
				mode = 'i',
				desc = 'Pick a [c]olor',
			},
		},
	},
}

return plugins
