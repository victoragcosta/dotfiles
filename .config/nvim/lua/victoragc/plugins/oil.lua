---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'stevearc/oil.nvim',
		dependencies = {
			{
				'nvim-tree/nvim-web-devicons',
				opts = {
					override_by_extension = {
						['local'] = {
							icon = ' ',
							name = 'DevIconSecret',
							color = '#999999',
						},
					},
				},
			},
		},
		config = function()
			-- remaps
			vim.keymap.set(
				'n',
				'<leader>oo',
				':Oil<CR>',
				{ desc = '[O]pen [O]il file manager' }
			)
			vim.keymap.set(
				'n',
				'<leader>of',
				':Oil --float<CR>',
				{ desc = 'Open [O]il file manager in a [f]loating window' }
			)
			require('oil').setup {
				columns = { 'icon' },
				default_file_explorer = true,
				keymaps = {
					-- Remove splits and add Ctrl + S for saving
					['<C-s>'] = ':w<CR>',
					['<C-h>'] = false,
					-- Adjust close to be my custom <Esc>
					['<leader>fj'] = 'actions.close',
					-- Adjust commands that change cwd
					['<leader>cd'] = 'actions.cd',
					['<leader>tcd'] = 'actions.tcd',
					['`'] = false,
					['~'] = false,
				},
				view_options = { show_hidden = true },
				win_options = {
					signcolumn = 'yes:2',
				},
			}
		end,
	},
	{
		'refractalize/oil-git-status.nvim',

		cond = not vim.g.started_by_firenvim,
		dependencies = {
			'stevearc/oil.nvim',
		},

		config = true,
	},
}

return plugins
