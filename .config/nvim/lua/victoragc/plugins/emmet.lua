require 'url'

vim.pack.add {
	github 'olrtg/nvim-emmet',
}

vim.keymap.set(
	'n',
	'<leader>xe',
	require('nvim-emmet').wrap_with_abbreviation,
	{
		desc = 'Wrap with [e]mmet abbreviation',
	}
)

vim.keymap.set(
	'v',
	'<leader>xe',
	require('nvim-emmet').wrap_with_abbreviation,
	{
		desc = 'Wrap with [e]mmet abbreviation',
	}
)
