require 'url'

vim.pack.add {
	-- Highlight todo, notes, etc in comments
	github 'folke/todo-comments.nvim',
}

require('todo-comments').setup { signs = false }
