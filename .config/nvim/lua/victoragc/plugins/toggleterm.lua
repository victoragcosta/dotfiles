local lazygit_terminal = nil
local toggleterm_direction = 'horizontal'

---@type (string | LazyPluginSpec)[]
local plugins = {
	{
		'akinsho/toggleterm.nvim',
		opts = {
			open_mapping = {},
		},
		keys = {
			{
				'<leader>tT',
				function()
					if toggleterm_direction == 'horizontal' then
						toggleterm_direction = 'vertical'
					else
						toggleterm_direction = 'horizontal'
					end
				end,
				desc = '[T]oggle [T]erminal direction',
			},
			{
				'<C-\\>',
				function()
					require('toggleterm').toggle(
						vim.v.count1,
						nil,
						nil,
						toggleterm_direction
					)
				end,
				desc = 'Toggle terminals',
			},
			{
				'<leader>lg',
				function()
					if lazygit_terminal == nil then
						local Terminal = require('toggleterm.terminal').Terminal
						lazygit_terminal =
							Terminal:new { cmd = 'lazygit', direction = 'tab', hidden = true }
					end

					lazygit_terminal:toggle()
				end,
				desc = '[L]azy[g]it',
			},
		},
	},
}

return plugins
