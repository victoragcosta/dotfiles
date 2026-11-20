-- Compatibility aliases for the legacy nvim-lspconfig commands.
--
-- Neovim 0.12+ provides the built-in `:lsp` command, so nvim-lspconfig
-- intentionally skips defining `:LspInfo`, `:LspLog`, `:LspStart`, `:LspStop`
-- and `:LspRestart` when it detects it. Recreate them as thin aliases so old
-- muscle memory and instructions from other plugins keep working.
local M = {}

local function complete_clients(arg_lead)
	return vim
		.iter(vim.lsp.get_clients())
		:map(function(client)
			return client.name
		end)
		:unique()
		:filter(function(name)
			return name:sub(1, #arg_lead) == arg_lead
		end)
		:totable()
end

local function complete_configs(arg_lead)
	return vim
		.iter(vim.lsp.get_configs())
		:map(function(config)
			return config.name
		end)
		:unique()
		:filter(function(name)
			return name:sub(1, #arg_lead) == arg_lead
		end)
		:totable()
end

--- Define `name` only if nothing else already provides it.
---@param name string
---@param command function
---@param opts vim.api.keyset.user_command
local function define(name, command, opts)
	if vim.fn.exists(':' .. name) == 0 then
		vim.api.nvim_create_user_command(name, command, opts)
	end
end

---@param command string
---@param args string
---@return string
local function with_args(command, args)
	if args == '' then
		return command
	end
	return command .. ' ' .. args
end

---Show which built-in command replaces a legacy alias.
---@param legacy string
---@param equivalent string|nil When nil, the legacy command has no `:lsp` equivalent.
local function notify_equivalent(legacy, equivalent)
	local msg
	if equivalent then
		msg = ('`:%s` is a legacy alias; use `:%s` instead'):format(
			legacy,
			equivalent
		)
	else
		msg = ('`:%s` is a legacy alias with no `:lsp` equivalent'):format(
			legacy
		)
	end

	local notify = _G.MiniNotify
	if notify then
		local id = notify.add(msg, 'INFO', 'DiagnosticInfo')
		vim.defer_fn(function()
			notify.remove(id)
		end, 5000)
	else
		vim.notify(msg, vim.log.levels.INFO)
	end
end

M.setup = function()
	-- Only fill the gap left by nvim-lspconfig on Neovim 0.12+. On older
	-- versions nvim-lspconfig still defines these commands itself.
	if vim.fn.exists ':lsp' ~= 2 then
		return
	end

	define('LspInfo', function()
		notify_equivalent('LspInfo', 'checkhealth vim.lsp')
		vim.cmd 'checkhealth vim.lsp'
	end, { desc = 'Alias for `:checkhealth vim.lsp`' })

	define('LspLog', function()
		notify_equivalent('LspLog')
		vim.cmd('tabnew ' .. vim.lsp.log.get_filename())
	end, { desc = 'Open the Nvim LSP client log' })

	define('LspStart', function(info)
		notify_equivalent('LspStart', with_args('lsp enable', info.args))
		vim.cmd('lsp enable ' .. info.args)
	end, {
		desc = 'Alias for `:lsp enable`',
		nargs = '*',
		complete = complete_configs,
	})

	define('LspStop', function(info)
		notify_equivalent('LspStop', with_args('lsp stop', info.args))
		vim.cmd('lsp stop ' .. info.args)
	end, {
		desc = 'Alias for `:lsp stop`',
		nargs = '*',
		complete = complete_clients,
	})

	define('LspRestart', function(info)
		notify_equivalent('LspRestart', with_args('lsp restart', info.args))

		local names = info.fargs

		-- Like the old nvim-lspconfig command, default to every active client
		-- instead of only the clients attached to the current buffer.
		if #names == 0 then
			names = vim
				.iter(vim.lsp.get_clients())
				:map(function(client)
					return client.name
				end)
				:unique()
				:totable()
		end

		if #names > 0 then
			vim.cmd('lsp restart ' .. table.concat(names, ' '))
		end
	end, {
		desc = 'Alias for `:lsp restart`',
		nargs = '*',
		complete = complete_clients,
	})
end

return M
