local module_key = 'victoragc_command_hotkey'

local remember_command = function()
	local last_command = vim.fn.histget('cmd', 1) or ''
	local command = vim.fn.input(
		string.format('Command to remember (%s): ', last_command),
		'',
		'command'
	)

	if command == '' then
		vim.notify 'Command hotkey: no command set'
		return
	end

	if not vim.g[module_key] then
		vim.g[module_key] = {}
	end
	local memory = vim.g[module_key]

	memory.command = command

	-- This is needed due to a bug in mutating table keys in vim.g
	-- See https://github.com/nanotee/nvim-lua-guide?tab=readme-ov-file#caveats-3
	vim.g[module_key] = memory

	vim.notify(string.format('Saved command "%s"', vim.g[module_key].command))
end

local run_command = function()
	local memory = vim.g[module_key]
	if not memory or not memory.command then
		vim.notify 'Command hotkey: no command set'
		return
	end

	vim.notify(string.format('Command hotkey: running "%s"', memory.command))
	vim.cmd(memory.command)
end

vim.keymap.set(
	'n',
	'<leader>xs',
	remember_command,
	{ desc = '[S]ave a command to easily remember later' }
)
vim.keymap.set(
	'n',
	'<leader>xr',
	run_command,
	{ desc = '[R]emember a command that has been saved before' }
)
