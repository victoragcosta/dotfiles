---@type (string | LazyPluginSpec)[]
local plugins = {
	-- -- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim', event = 'VeryLazy', opts = {} },
}

return plugins
