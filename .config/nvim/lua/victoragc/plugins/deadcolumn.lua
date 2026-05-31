require 'url'

vim.pack.add {
	-- Shows a colored column when you get close to it or past it
	github 'Bekaboo/deadcolumn.nvim',
}
require('deadcolumn').setup {
	scope = 'visible',
	modes = function(mode)
		return mode:find '^[nictRss\x13]' ~= nil
	end,
	extra = {
		follow_tw = '+1',
	},
}
