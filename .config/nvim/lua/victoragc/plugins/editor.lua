return {
	-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
	'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

	-- NOTE: Plugins can also be added by using a table,
	-- with the first argument being the link and the following
	-- keys can be used to configure plugin behavior/loading/etc.
	--
	-- Use `opts = {}` to force a plugin to be loaded.
	--
	--  This is equivalent to:
	--    require('Comment').setup({})

	-- -- "gc" to comment visual regions/lines
	'numToStr/Comment.nvim',
	-- Highlight todo, notes, etc in comments
	{
		'folke/todo-comments.nvim',
		event = 'VimEnter',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = { signs = false },
	},
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		-- Optional dependency
		dependencies = { 'hrsh7th/nvim-cmp' },
		config = function()
			require('nvim-autopairs').setup {}
			-- If you want to automatically add `(` after selecting a function or method
			local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
			local cmp = require 'cmp'
			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		end,
	},
	{ -- Collection of various small independent plugins/modules
		'echasnovski/mini.nvim',
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require('mini.ai').setup { n_lines = 500 }

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require('mini.surround').setup()

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require 'mini.statusline'
			-- set use_icons to true if you have a Nerd Font
			statusline.setup { use_icons = vim.g.have_nerd_font }

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return '%2l:%-2v'
			end
			-- Set file info to contain indentation information
			local old_section_fileinfo = statusline.section_fileinfo
			--- @diagnostic disable-next-line: duplicate-set-field
			statusline.section_fileinfo = function(args)
				-- Return original string if truncated
				if statusline.is_truncated(args.trunc_width) then
					return old_section_fileinfo(args)
				end

				local tab = 'Tabs'
				if vim.bo.expandtab then
					tab = 'Spaces'
				end

				local indent_size = vim.bo.tabstop

				return string.format('%s %s %d', old_section_fileinfo(args), tab, indent_size)
			end
			-- ... and there is more!
			--  check out: https://github.com/echasnovski/mini.nvim
		end,
	},
	{
		'smoka7/hop.nvim',
		event = 'VimEnter',
		version = '*',
		opts = {
			keys = 'etovxqpdygfblzhckisuran',
		},
		keys = function()
			local hop = require 'hop'
			local directions = require('hop.hint').HintDirection
			return {
				{
					'f',
					function()
						hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true }
					end,
					desc = 'Hop forwards to specific character on a line',
				},
				{
					'F',
					function()
						hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true }
					end,
					desc = 'Hop backwards to specific character on a line',
				},
				{
					't',
					function()
						hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }
					end,
					desc = 'Hop forwards before an specific character on a line',
				},
				{
					'T',
					function()
						hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }
					end,
					desc = 'Hop backwards after an specific character on a line',
				},
				{
					'<leader>H',
					function()
						hop.hint_words {}
					end,
					desc = 'Hop to some visible word',
				},
			}
		end,
	},
	{
		'olrtg/nvim-emmet',
		keys = function()
			return {
				{ '<leader>xe', require('nvim-emmet').wrap_with_abbreviation, mode = 'n', desc = 'Wrap with [e]mmet abbreviation' },
				{ '<leader>xe', require('nvim-emmet').wrap_with_abbreviation, mode = 'v', desc = 'Wrap with [e]mmet abbreviation' },
			}
		end,
	},
	{
		'mbbill/undotree',
		keys = {
			{ '<leader>u', vim.cmd.UndotreeToggle },
		},
	},
}
