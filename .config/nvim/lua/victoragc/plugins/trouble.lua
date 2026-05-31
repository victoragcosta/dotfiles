require 'url'

vim.pack.add {
	github 'folke/trouble.nvim',
}
require('trouble').setup {
	warn_no_results = false,
	open_no_results = true,
}

vim.keymap.set('n', '<leader>q', '<Cmd>Trouble diagnostics toggle<CR>', {
	desc = '[T]oggle diagnostics (Trouble  x)',
})
vim.keymap.set(
	'n',
	'<leader>dq',
	'<Cmd>Trouble diagnostics toggle filter.buf=0<CR>',
	{
		desc = '[D]ocument Diagnostics (Trouble  x)',
	}
)
vim.keymap.set(
	'n',
	'<leader>ds',
	'<Cmd>Trouble symbols toggle focus=false<CR>',
	{
		desc = '[D]ocument [s]ymbols (Trouble)',
	}
)
vim.keymap.set(
	'n',
	'<leader>tl',
	'<Cmd>Trouble lsp toggle focus=false win.position=right<CR>',
	{
		desc = '[T]oggle [L]SP Definitions / references / ... (Trouble)',
	}
)
