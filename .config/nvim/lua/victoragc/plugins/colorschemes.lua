require 'url'

vim.pack.add {
	github 'folke/tokyonight.nvim',
}

---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {
	transparent = not vim.g.neovide,
}

vim.cmd.colorscheme 'tokyonight-night'

-- You can configure highlights by doing something like:
vim.cmd.hi 'Comment gui=none'

-- Tabline
vim.cmd.hi 'TabLineHead guibg=#7aa2f7 guifg=#15161e'
vim.cmd.hi 'TabLineIn guibg=#8e9db5 guifg=#15161e'
