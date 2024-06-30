---@type ( string | LazyPluginSpec )[]
local plugins = {
	{
		'mbbill/undotree',
		keys = {
			{ '<leader>u', vim.cmd.UndotreeToggle, desc = 'Toggle [U]ndotree' },
		},
	},
}
return plugins
