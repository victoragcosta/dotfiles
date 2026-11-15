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
		chat = {
			tools = {
				['web_search'] = {
					opts = {
						adapter = 'duckduckgo',
					},
				},
				-- The default is a function, which the session serialiser can't encode
				['grep_search'] = {
					enabled = true,
				},
			},
			adapter = 'deepseek',
		},
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

vim.keymap.set(
	{ 'n', 'v' },
	'<C-a>',
	'<cmd>CodeCompanionActions<cr>',
	{ noremap = true, silent = true, desc = 'Open CodeCompanion [a]ctions' }
)
vim.keymap.set(
	{ 'n', 'v' },
	'<leader>cr',
	'<cmd>CodeCompanionCodeReview<cr>',
	{ noremap = true, silent = true, desc = 'Open [C]odeCompanion code [r]eview' }
)
vim.keymap.set(
	{ 'n', 'v' },
	'<leader>cc',
	'<cmd>CodeCompanionChat Toggle<cr>',
	{
		noremap = true,
		silent = true,
		desc = 'Toggle [C]ode[C]ompanion chat window',
	}
)
vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', {
	noremap = true,
	silent = true,
	desc = '[A]dd visual selection to current CodeCompanion chat',
})

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd [[cab cc CodeCompanion]]
