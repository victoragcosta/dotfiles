local helpers = require 'victoragc.plugins.lspconfig.helpers'
---@type table<string,function>
local capabilities = {}

capabilities.install_highlight = function(buf)
	local highlight_augroup =
		vim.api.nvim_create_augroup('victoragc-lsp-highlight', { clear = false })

	-- Highlight the token you're on when your cursor stops
	vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
		buffer = buf,
		group = highlight_augroup,
		callback = vim.lsp.buf.document_highlight,
	})

	-- Remove the highlight if you move your cursor
	vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
		buffer = buf,
		group = highlight_augroup,
		callback = vim.lsp.buf.clear_references,
	})

	-- Clear these autocommands when the LSP detaches (cleanup)
	vim.api.nvim_create_autocmd('LspDetach', {
		group = vim.api.nvim_create_augroup(
			'victoragc-lsp-detach',
			{ clear = true }
		),
		callback = function(event2)
			vim.lsp.buf.clear_references()
			vim.api.nvim_clear_autocmds {
				group = 'victoragc-lsp-highlight',
				buffer = event2.buf,
			}
		end,
	})
end

capabilities.install_inlay_hint_toggler = function(buf)
	local map = helpers.create_keymapper(buf)

	local notify_inlay_hint_state = function()
		local enabled = 'off'
		if vim.lsp.inlay_hint.is_enabled {} then
			enabled = 'on'
		end
		vim.notify(string.format('Inlay hint toggled %s', enabled))
	end

	map('<leader>th', function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
		-- notify the user the state of inlay hints
		notify_inlay_hint_state()
	end, '[T]oggle Inlay [H]ints')

	notify_inlay_hint_state()
end

return capabilities
