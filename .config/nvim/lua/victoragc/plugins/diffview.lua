require 'url'

vim.pack.add {
	github 'sindrets/diffview.nvim',
}

require('diffview').setup {
	view = {
		merge_tool = {
			layout = 'diff3_mixed',
		},
	},
}
