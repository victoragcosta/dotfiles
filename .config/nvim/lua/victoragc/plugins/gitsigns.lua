---@type ( string | LazyPluginSpec )[]
local plugins = {
	-- Adds git related signs to the gutter, as well as utilities for managing changes
	-- See `:help gitsigns` to understand what the configuration keys do
	{
		'lewis6991/gitsigns.nvim',
		cond = not vim.g.started_by_firenvim,
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				local gitsigns = require 'gitsigns'

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map('n', ']c', function()
					if vim.wo.diff then
						vim.cmd.normal { ']c', bang = true }
					else
						gitsigns.nav_hunk 'next'
					end
				end, { desc = 'Jump to next git [c]hange' })

				map('n', '[c', function()
					if vim.wo.diff then
						vim.cmd.normal { '[c', bang = true }
					else
						gitsigns.nav_hunk 'prev'
					end
				end, { desc = 'Jump to previous git [c]hange' })

				-- Actions
				-- visual mode
				map('v', '<leader>Hs', function()
					gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
				end, { desc = 'stage git hunk' })
				map('v', '<leader>Hr', function()
					gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
				end, { desc = 'reset git hunk' })
				-- normal mode
				map(
					'n',
					'<leader>Hs',
					gitsigns.stage_hunk,
					{ desc = 'git [s]tage hunk' }
				)
				map(
					'n',
					'<leader>Hr',
					gitsigns.reset_hunk,
					{ desc = 'git [r]eset hunk' }
				)
				map(
					'n',
					'<leader>HS',
					gitsigns.stage_buffer,
					{ desc = 'git [S]tage buffer' }
				)
				map(
					'n',
					'<leader>HR',
					gitsigns.reset_buffer,
					{ desc = 'git [R]eset buffer' }
				)
				map(
					'n',
					'<leader>Hp',
					gitsigns.preview_hunk,
					{ desc = 'git [p]review hunk' }
				)
				map(
					'n',
					'<leader>Hb',
					gitsigns.blame_line,
					{ desc = 'git [b]lame line' }
				)
				map('n', '<leader>HB', gitsigns.blame, { desc = 'git [B]lame buffer' })
				map(
					'n',
					'<leader>Hd',
					gitsigns.diffthis,
					{ desc = 'git [d]iff against index' }
				)
				map('n', '<leader>HD', function()
					gitsigns.diffthis '@'
				end, { desc = 'git [D]iff against last commit' })
				map(
					'n',
					'<leader>Hq',
					gitsigns.setqflist,
					{ desc = 'git [q]uickfix list' }
				)
				-- Toggles
				map(
					'n',
					'<leader>tb',
					gitsigns.toggle_current_line_blame,
					{ desc = '[T]oggle git show [b]lame line' }
				)
				map(
					'n',
					'<leader>tH',
					gitsigns.preview_hunk_inline,
					{ desc = '[T]oggle git preview [H]unk inline' }
				)

				map(
					{ 'o', 'x' },
					'ih',
					gitsigns.select_hunk,
					{ desc = '[i]nside [h]unk' }
				)
			end,
		},
	},
}

return plugins
