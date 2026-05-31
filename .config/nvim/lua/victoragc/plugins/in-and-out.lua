require 'url'

vim.pack.add {
	github 'ysmb-wtsg/in-and-out.nvim',
}

vim.keymap.set({ 'i' }, '<M-i>', function()
	require('in-and-out').in_and_out()
end, { desc = 'Move out of punctuation pairs with [i]n and out' })
