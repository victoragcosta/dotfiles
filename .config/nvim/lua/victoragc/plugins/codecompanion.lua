require 'url'

vim.pack.add { github 'nvim-lua/plenary.nvim' }
-- Already installed in its own file
-- vim.pack.add { github 'nvim-treesitter/nvim-treesitter' }
vim.pack.add {
	{
		src = github 'olimorris/codecompanion.nvim',
		version = vim.version.range '^19.0.0',
	},
}

-- Somewhere in your config
require('codecompanion').setup {
	interactions = {
		chat = { adapter = 'deepseek' },
		inline = { adapter = 'deepseek' },
	},
	adapters = {
		http = {
			deepseek = function()
				return require('codecompanion.adapters').extend('deepseek', {
					env = {
						api_key = 'file:~/dotfiles/.deepseek_api_key.local',
					},
				})
			end,
		},
	},
}
