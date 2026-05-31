require 'url'

vim.pack.add {
	github 'stevearc/conform.nvim',
}
require('conform').setup {
	notify_on_error = false,
	format_on_save = function(bufnr)
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		-- Disable "format_on_save lsp_fallback" for languages that don't
		-- have a well standardized coding style. You can add additional
		-- languages here or re-enable it for the disabled ones.
		local disable_filetypes = { c = true, cpp = true }
		return {
			timeout_ms = 500,
			lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
		}
	end,
	default_format_opts = {
		lsp_format = 'fallback',
	},
	formatters_by_ft = {
		lua = { 'stylua' },
		-- Conform can also run multiple formatters sequentially
		-- python = { "isort", "black" },
		--
		-- You can use a sub-list to tell conform to run *until* a formatter
		-- is found.
		javascript = { 'prettierd' },
		typescript = { 'prettierd' },
		javascriptreact = { 'prettierd' },
		typescriptreact = { 'prettierd' },
		svelte = { 'prettierd' },
		markdown = { 'prettierd' },
		graphql = { 'prettierd' },
		html = { 'prettierd' },
		css = { 'prettierd' },

		rust = { 'rustfmt' },
		nix = { 'nixfmt' },
	},
}
vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
	require('conform').format { async = true }
end, { desc = '[F]ormat buffer' })
