require 'url'

vim.pack.add {
	github 'nvim-treesitter/nvim-treesitter-context',
}

require('treesitter-context').setup {
	min_window_height = 36,
	max_lines = 6,
	multiline_threshold = 1,
	trim_scope = 'outer',
}

vim.keymap.set('n', '<leader>tc', function()
	require('treesitter-context').toggle()
end, {
	desc = '[T]oggle treesitter [c]ontext',
})

vim.keymap.set('n', '[c', function()
	require('treesitter-context').go_to_context(vim.v.count1)
end, {
	desc = 'Go up [c]ontext',
	silent = true,
})
