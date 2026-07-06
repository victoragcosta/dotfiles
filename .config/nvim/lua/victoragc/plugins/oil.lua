require 'url'

vim.pack.add {
	github 'stevearc/oil.nvim',
	github 'nvim-tree/nvim-web-devicons',
	github 'refractalize/oil-git-status.nvim',
}

require('nvim-web-devicons').setup {
	override_by_extension = {
		['local'] = {
			icon = ' ',
			name = 'DevIconSecret',
			color = '#999999',
		},
	},
}

require('oil').setup {
	columns = { 'icon' },
	default_file_explorer = true,
	keymaps = {
		-- Remove splits and add Ctrl + S for saving
		['<C-s>'] = ':w<CR>',
		['<C-h>'] = false,
		-- Adjust close to be my custom <Esc>
		['<leader>fj'] = 'actions.close',
		-- Adjust commands that change cwd
		['<leader>cd'] = 'actions.cd',
		['<leader>tcd'] = 'actions.tcd',
		['`'] = false,
		['~'] = false,
	},
	view_options = { show_hidden = true },
	win_options = {
		signcolumn = 'yes:2',
	},
}

require('oil-git-status').setup {}

-- remaps
vim.keymap.set(
	'n',
	'<leader>oo',
	':Oil<CR>',
	{ desc = '[O]pen [O]il file manager' }
)
vim.keymap.set(
	'n',
	'<leader>of',
	':Oil --float<CR>',
	{ desc = 'Open [O]il file manager in a [f]loating window' }
)

-- Change CWD when initializing with a directory argument
if vim.g.victoragc.autocwd_on_startup then
	vim.api.nvim_create_autocmd('VimEnter', {
		desc = 'Change CWD to the directory passed as argument',
		group = CwdGroup,
		callback = function()
			local dir = require('oil').get_current_dir()
			if dir then
				vim.api.nvim_set_current_dir(dir)
			end
		end,
	})
end
