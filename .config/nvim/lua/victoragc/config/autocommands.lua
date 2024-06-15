if not vim.g.victoragc then
	vim.g.victoragc = {
		autocwd_on_startup = true,
		notify_cwd_change = false,
	}
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('victoragc-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Source configs when any file in victoragc.config is changed
-- TODO: actually implement this autocommand without much duplication

-- Notify of a CWD change
local cwd_group = vim.api.nvim_create_augroup('victoragc-cwd', { clear = true })
if vim.g.victoragc.notify_cwd_change then
	vim.api.nvim_create_autocmd('DirChanged', {
		-- pattern = 'global',
		desc = 'Notify of a cwd change',
		group = cwd_group,
		callback = function()
			local function format_cwd()
				return string.format('Changed CWD to %s in %s', vim.v.event.cwd, vim.v.event.scope)
			end
			local notification_id = MiniNotify.add(format_cwd())
			vim.defer_fn(function()
				MiniNotify.remove(notification_id)
			end, 5000)
		end,
	})
end

-- Change CWD when initializing with a directory argument
if vim.g.victoragc.autocwd_on_startup then
	vim.api.nvim_create_autocmd('VimEnter', {
		desc = 'Change CWD to the directory passed as argument',
		group = cwd_group,
		callback = function()
			local dir = require('oil').get_current_dir()
			if dir then
				vim.api.nvim_set_current_dir(dir)
			end
		end,
	})
end
