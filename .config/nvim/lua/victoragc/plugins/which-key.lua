---@type ( string | LazyPluginSpec )[]
local plugins = {
	{ -- Useful plugin to show you pending keybinds.
		'folke/which-key.nvim',
		event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require('which-key').setup {
				triggers = {
					{ '<auto>', mode = 'nxsot' },
				},
			}

			-- Document existing key chains
			require('which-key').add {
				{ '<leader>c', group = '[C]ode' },
				{ '<leader>d', group = '[D]ocument' },
				{ '<leader>d!', group = '[D]ocument [!]force' },
				{ '<leader>H', group = 'Git [H]unk' },
				{ '<leader>o', group = '[O]il file manager' },
				{ '<leader>r', group = '[R]ename' },
				{ '<leader>s', group = '[S]earch' },
				{ '<leader>t', group = '[T]oggle' },
				{ '<leader>tw', group = '[T]oggle Tail[w]ind' },
				{ '<leader>x', group = 'E[x]ecute' },
				{ '<leader>xc', group = '[C]olor' },
				{ '<leader>H', group = 'Git [H]unk', mode = 'v' },
			}
		end,
	},
}
return plugins
