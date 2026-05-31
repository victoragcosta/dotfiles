require 'url'

vim.pack.add {
	github 'mbbill/undotree',
}
-- Doesn't need setup
-- require('undotree').setup()

vim.keymap.set(
	'n',
	'<leader>u',
	vim.cmd.UndotreeToggle,
	{ desc = 'Toggle [U]ndotree' }
)
