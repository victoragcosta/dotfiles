---@type ( string | LazyPluginSpec )[]
local plugins = {
	{ -- Useful plugin to show you pending keybinds.
		'folke/which-key.nvim',
		event = 'VimEnter', -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require('which-key').setup {
				triggers_blacklist = {
					i = { 'f', 'j', 'k' },
					v = { 'f', 'j', 'k' },
				},
			}

			-- Document existing key chains
			require('which-key').register {
				['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
				['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
				['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
				['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
				['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
				['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
				['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
				['<leader>b'] = { name = '[B]uffer', _ = 'which_key_ignore' },
				['<leader>o'] = { name = '[O]il file manager', _ = 'which_key_ignore' },
				['<leader>x'] = { name = '[E]xecute', _ = 'which_key_ignore' },
				['<leader>d!'] = {
					name = '[D]ocument [!]force',
					_ = 'which_key_ignore',
				},
			}
			-- visual mode
			require('which-key').register({
				['<leader>h'] = { 'Git [H]unk' },
			}, { mode = 'v' })
		end,
	},
}
return plugins
