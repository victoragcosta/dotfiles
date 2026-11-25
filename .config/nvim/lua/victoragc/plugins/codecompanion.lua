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
				['read_file'] = {
					opts = {
						require_approval_before = false,
					},
				},
				-- The default is a function, which the session serialiser can't encode
				['grep_search'] = {
					enabled = true,
					opts = {
						require_approval_before = false,
					},
				},
				['insert_edit_into_file'] = {
					opts = {
						-- Apply edits without asking before or confirming after
						require_approval_before = false,
						require_confirmation_after = false,
					},
				},
			},
			adapter = 'deepseek_work',
		},
		inline = { adapter = 'deepseek_work' },
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
			deepseek_work = function()
				return require('codecompanion.adapters').extend('deepseek', {
					env = {
						api_key = 'file:~/dotfiles/.deepseek_api_key_work.local',
					},
				})
			end,
			chatgpt = function()
				return require('codecompanion.adapters').extend('openai', {
					name = 'chatgpt',
					formatted_name = 'ChatGPT',
					env = {
						api_key = 'file:~/dotfiles/.chatgpt_api_key.local',
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
