---@type (string| LazyPluginSpec)[]
local plugins = {
	{ -- Fuzzy Finder (files, lsp, etc)
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				'nvim-telescope/telescope-fzf-native.nvim',

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = 'make',

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			{ 'nvim-telescope/telescope-ui-select.nvim' },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
			'keyvchan/telescope-find-pickers.nvim',
		},
		config = function()
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
			pcall(telescope.load_extension, 'nerdy')
			pcall(telescope.load_extension, 'find_pickers')

			-- See `:help telescope.builtin`
		end,
		keys = function()
			local keys = {}
			local map = function(mode, rhs, lhs, opts)
				table.insert(
					keys,
					vim.tbl_extend('force', { rhs, lhs, mode = mode or 'n' }, opts)
				)
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
			map(
				'n',
				'<leader>sd',
				builtin.diagnostics,
				{ desc = '[S]earch [D]iagnostics' }
			)
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
				builtin.current_buffer_fuzzy_find(
					require('telescope.themes').get_dropdown {
						winblend = 10,
						previewer = false,
					}
				)
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

			return keys
		end,
	},
}
return plugins
