require 'url'

vim.pack.add {
	github 'akinsho/git-conflict.nvim',
}

if not vim.g.started_by_firenvim then
	require('git-conflict').setup {}
	vim.keymap.set('n', '<leader>HQ', '<cmd>GitConflictListQf<cr>', {
		desc = 'git set [Q]uickfix list for repo',
	})
end
