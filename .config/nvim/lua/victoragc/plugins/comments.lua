require 'url'

vim.pack.add {
	-- "gc" to comment visual regions/lines
	github 'numToStr/Comment.nvim',
	-- deal with hard files like tsx/jsx
	github 'JoosepAlviste/nvim-ts-context-commentstring',
}

require('ts_context_commentstring').setup {
	enable_autocmd = false,
}
---@diagnostic disable-next-line: missing-fields
require('Comment').setup {
	pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
