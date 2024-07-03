---@type (string | LazyPluginSpec)[]
local plugins = {
	-- Shows a colored column when you get close to it or past it
	{
		'Bekaboo/deadcolumn.nvim',
		opts = {
			scope = 'visible',
			modes = function(mode)
				return mode:find '^[nictRss\x13]' ~= nil
			end,
			extra = {
				follow_tw = '+1',
			},
		},
	},
}

return plugins
