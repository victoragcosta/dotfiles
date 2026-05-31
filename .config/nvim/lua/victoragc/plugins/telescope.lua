require 'url'

vim.pack.add {
	-- Fuzzy Finder (files, lsp, etc)
	{
		src = github 'nvim-telescope/telescope.nvim',
		version = vim.version.range '0.1.*',
	},
	github 'nvim-lua/plenary.nvim',
	github 'nvim-telescope/telescope-ui-select.nvim',
	github 'keyvchan/telescope-find-pickers.nvim',
}
if vim.g.have_nerd_font then
	vim.pack.add {
		-- Lets me search for nerd icons with telescope
		github '2kabhishek/nerdy.nvim',
		-- Useful for getting pretty icons, but requires a Nerd Font.
		github 'nvim-tree/nvim-web-devicons',
	}
end
if vim.fn.executable 'make' == 1 then
	vim.pack.add {
		-- If encountering errors, see telescope-fzf-native README for installation instructions
		github 'nvim-telescope/telescope-fzf-native.nvim',
	}
end

local telescope = require 'telescope'
telescope.setup {
	-- You can put your default mappings / updates / etc. in here
	--  All the info you're looking for is in `:help telescope.setup()`
	--
	defaults = {
		mappings = {
			-- i = { ['<c-enter>'] = 'to_fuzzy_refine' },
			n = {
				['<leader><leader>'] = 'close',
				-- Disable <leader>+<hjkl> for window navigation
				['<leader>j'] = function() end,
				['<leader>k'] = function() end,
				['<leader>h'] = function() end,
				['<leader>l'] = function() end,
			},
			i = { ['<leader><leader>'] = 'close' },
		},
	},
	-- pickers = {}
	extensions = {
		['ui-select'] = {
			require('telescope.themes').get_dropdown(),
		},
	},
}

-- Enable Telescope extensions if they are installed
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')
pcall(telescope.load_extension, 'find_pickers')
pcall(telescope.load_extension, 'nerdy')

local map = function(mode, rhs, lhs, opts)
	vim.keymap.set({ mode or 'n' }, rhs, lhs, opts)
end

local telescope = require 'telescope'
local builtin = require 'telescope.builtin'
map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
map(
	'n',
	'<leader>ss',
	telescope.extensions.find_pickers.find_pickers,
	{ desc = '[S]earch [S]elect Telescope' }
)
map(
	'n',
	'<leader>sw',
	builtin.grep_string,
	{ desc = '[S]earch current [W]ord' }
)
map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [g]rep' })
map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
map(
	'n',
	'<leader>s.',
	builtin.oldfiles,
	{ desc = '[S]earch Recent Files ("." for repeat)' }
)
map(
	'n',
	'<leader><leader>',
	builtin.buffers,
	{ desc = '[ ] Find existing buffers' }
)

-- Slightly advanced example of overriding default behavior and theme
map('n', '<leader>/', function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer' })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
map('n', '<leader>s/', function()
	builtin.live_grep {
		grep_open_files = true,
		prompt_title = 'Live Grep in Open Files',
	}
end, { desc = '[S]earch [/] in Open Files' })

-- Shortcut for searching your Neovim configuration files
map('n', '<leader>sn', function()
	builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })
