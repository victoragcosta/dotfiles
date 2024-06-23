---@type (string|LazyPluginSpec)[]
local plugins = {

	{ -- Linting
		'mfussenegger/nvim-lint',
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			local lint = require 'lint'

			-- Make cspell use a global config
			table.insert(lint.linters.cspell.args, 2, '--config')
			table.insert(
				lint.linters.cspell.args,
				3,
				string.format('%s/.config/cspell/cspell.config.js', os.getenv 'HOME')
			)

			-- Disable the default linters by setting their filetypes to nil:
			lint.linters_by_ft['clojure'] = nil
			lint.linters_by_ft['dockerfile'] = nil
			lint.linters_by_ft['inko'] = nil
			lint.linters_by_ft['janet'] = nil
			lint.linters_by_ft['json'] = nil
			lint.linters_by_ft['markdown'] = nil
			lint.linters_by_ft['rst'] = nil
			lint.linters_by_ft['ruby'] = nil
			lint.linters_by_ft['terraform'] = nil
			lint.linters_by_ft['text'] = nil

			-- Configure linter by language
			lint.linters_by_ft['markdown'] = { 'markdownlint' }
			lint.linters_by_ft['javascript'] = { 'eslint' }
			lint.linters_by_ft['typescript'] = { 'eslint' }
			lint.linters_by_ft['javascriptreact'] = { 'eslint' }
			lint.linters_by_ft['typescriptreact'] = { 'eslint' }
			lint.linters_by_ft['svelte'] = { 'eslint' }
			lint.linters_by_ft['*'] = { 'cspell' }

			-- Disable eslint if running on firenvim
			if vim.g.started_by_firenvim then
				for _, language in ipairs {
					'javascript',
					'typescript',
					'javascriptreact',
					'typescriptreact',
					'svelte',
				} do
					for i, v in ipairs(lint.linters_by_ft[language]) do
						if v == 'eslint' then
							table.remove(lint.linters_by_ft[language], i)
						end
					end
				end
			end

			-- Create autocommand which carries out the actual linting
			-- on the specified events.
			local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
			vim.api.nvim_create_autocmd(
				{ 'BufEnter', 'BufWritePost', 'InsertLeave' },
				{
					group = lint_augroup,
					callback = function()
						require('lint').try_lint()
					end,
				}
			)
		end,
	},
}

return plugins
