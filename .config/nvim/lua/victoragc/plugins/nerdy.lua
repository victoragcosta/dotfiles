---@type (string | LazyPluginSpec)[]
local plugins = {
	-- Let's me search for nerd icons with telescope
	{
		'2kabhishek/nerdy.nvim',
		dependencies = {
			'stevearc/dressing.nvim',
			'nvim-telescope/telescope.nvim',
		},
		cmd = 'Nerdy',
	},
}

return plugins
