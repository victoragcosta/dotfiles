require 'url'

vim.pack.add {
	-- Useful plugin to show you pending keybinds.
	github 'folke/which-key.nvim',
}
require('which-key').setup {
	icons = { mappings = vim.g.have_nerd_font },
	triggers = {
		{ '<auto>', mode = 'nxsot' },
	},
	spec = {
		{ '<leader>c', group = '[C]ode' },
		{ '<leader>d', group = '[D]ocument' },
		{ '<leader>d!', group = '[D]ocument [!]force' },
		{ '<leader>H', group = 'Git [H]unk' },
		{ '<leader>o', group = '[O]il file manager' },
		{ '<leader>r', group = '[R]ename' },
		{ '<leader>s', group = '[S]earch' },
		{ '<leader>t', group = '[T]oggle' },
		{ '<leader>tw', group = '[T]oggle Tail[w]ind' },
		{ '<leader>x', group = 'E[x]ecute' },
		{ '<leader>xc', group = '[C]olor' },
		{ '<leader>H', group = 'Git [H]unk', mode = 'v' },
	},
}
