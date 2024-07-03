---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'luckasRanarison/tailwind-tools.nvim',
		ft = {
			'html',
			'css',
			'jsx',
			'javascriptreact',
			'javascript',
			'tsx',
			'typescriptreact',
			'typescript',
			'svelte',
			'vue',
		},
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		opts = {
			document_color = {
				enabled = true,
				kind = 'background',
				symbol = '',
			},
			conceal = {
				enabled = true,
				symbol = '󱏿',
			},
		},
		keys = {
			{
				'<leader>twc',
				'<Cmd>TailwindConcealToggle<CR>',
				desc = '[T]oggle Tail[w]ind con[c]eal classes',
			},
			{
				'<leader>twl',
				'<Cmd>TailwindColorToggle<CR>',
				desc = '[T]oggle Tail[w]ind co[l]or indicators',
			},
		},
		cmd = {
			'TailwindConcealEnable',
			'TailwindConcealDisable',
			'TailwindConcealToggle',
			'TailwindColorEnable',
			'TailwindColorDisable',
			'TailwindColorToggle',
			'TailwindSort',
			'TailwindSortSelection',
			'TailwindNextClass',
			'TailwindPrevClass',
		},
	},
}

return plugins
