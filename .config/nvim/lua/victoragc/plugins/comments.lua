require 'url'

vim.pack.add(
	-- "gc" to comment visual regions/lines
	{ github 'numToStr/Comment.nvim' }
)
require('Comment').setup()
