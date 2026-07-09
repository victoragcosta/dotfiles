vim.pack.add {
	github 'nvim-mini/mini.nvim',
}
-- Better Around/Inside textobjects
require('mini.ai').setup {
	custom_textobjects = {
		-- Tweak argument to also be recognized inside balanced <>
		a = require('mini.ai').gen_spec.argument {
			brackets = { '%b()', '%b[]', '%b{}', '%b<>' },
			separator = '[,;]',
			exclude_regions = { '%b""', "%b''", '%b()', '%b[]', '%b{}', '%b<>' },
		},
		-- Function definition (needs treesitter queries with these captures)
		-- F = require('mini.ai').gen_spec.treesitter {
		-- 	a = '@function',
		-- 	i = 'body',
		-- },
	},
	n_lines = 500,
}

-- Add/delete/replace surroundings (brackets, quotes, etc.)
require('mini.surround').setup()

-- Remove buffers without affecting the window layout
require('mini.bufremove').setup {}

-- Scope indentation visualizer
if not vim.g.vscode then
	require('mini.indentscope').setup()
	vim.api.nvim_create_autocmd('TermOpen', {
		desc = 'Disable mini.indentscope when in terminal',
		group = vim.api.nvim_create_augroup(
			'victoragc-mini-indentscope',
			{ clear = true }
		),
		callback = function()
			vim.b.miniindentscope_disable = true
		end,
	})
end

-- Session management
local session_file_name = '.session.vim'
require('mini.sessions').setup {
	autoread = true,
	autowrite = true,
	file = session_file_name,
}
vim.keymap.set('n', '<leader>S', function()
	if not MiniSessions then
		return
	end
	MiniSessions.write(session_file_name)
end, { desc = 'Save [S]ession' })

-- Notification system
local notify = require 'mini.notify'
notify.setup()
vim.notify = notify.make_notify()

-- Bottom statusline
local statusline = require 'mini.statusline'
-- set use_icons to true if you have a Nerd Font
statusline.setup { use_icons = vim.g.have_nerd_font }

-- Set to show <line number>:<character column number> in the location section
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

	-- Return original string if it's not a normal file
	-- (no need for tabs and spaces if not a file)
	local filetype = vim.bo.filetype
	if filetype == '' or vim.bo.buftype ~= '' then
		return old_section_fileinfo(args)
	end

	local tab = 'Tabs'
	if vim.bo.expandtab then
		tab = 'Spaces'
	end

	local indent_size = vim.bo.tabstop

	return string.format('%s %s %d', old_section_fileinfo(args), tab, indent_size)
end
