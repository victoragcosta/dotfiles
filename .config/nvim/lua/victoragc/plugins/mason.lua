require 'url'

vim.pack.add {
	github 'neovim/nvim-lspconfig',
	github 'mason-org/mason.nvim',
	github 'mason-org/mason-lspconfig.nvim',
	github 'WhoIsSethDaniel/mason-tool-installer.nvim',
	github 'b0o/schemastore.nvim',
}

-- Enable the following language servers
--
--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
local schemastore = require 'schemastore'
---@type { [string]: vim.lsp.Config }
local lsp_configs = {
	-- See `:help lspconfig-all` for a list of all the pre-configured LSPs
	--
	-- Some languages (like typescript) have entire language plugins that can be useful:
	--    https://github.com/pmizio/typescript-tools.nvim
	--
	-- But for many setups, the LSP (`tsserver`) will work just fine

	-- HTML
	html = {},
	emmet_language_server = {},
	-- CSS
	cssls = {},
	css_variables = {},
	tailwindcss = {},
	-- TS, JS and related
	-- ts_ls = {
	-- 	---@type lspconfig.settings.ts_ls
	-- 	settings = {},
	-- },
	tsgo = {
		-- TODO: eventually fix this type

		---@type lspconfig.settings.tsgo
		settings = {},
	},
	svelte = {
		---@type lspconfig.settings.svelte
		settings = {
			svelte = {
				['enable-ts-plugin'] = true,
				plugin = {
					svelte = {
						defaultScriptLanguage = 'ts',
					},
				},
			},
		},
	},

	eslint = {
		---@type lspconfig.settings.eslint
		settings = {
			eslint = {},
		},
	},
	graphql = {},

	-- Other languages
	rust_analyzer = {},
	lua_ls = {
		on_init = function(client)
			client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath 'config'
					and (
						vim.uv.fs_stat(path .. '/.luarc.json')
						or vim.uv.fs_stat(path .. '/.luarc.jsonc')
					)
				then
					return
				end
			end

			client.config.settings.Lua =
				---@diagnostic disable-next-line: param-type-mismatch
				vim.tbl_deep_extend('force', client.config.settings.Lua, {
					workspace = {
						checkThirdParty = false,
						-- NOTE: this is a lot slower and will cause issues when working on your own configuration.
						--  See https://github.com/neovim/nvim-lspconfig/issues/3189
						library = vim.tbl_extend(
							'force',
							vim.tbl_filter(function(d)
								return not d:match(vim.fn.stdpath 'config' .. '/?a?f?t?e?r?')
							end, vim.api.nvim_get_runtime_file('', true)),
							{
								'${3rd}/luv/library',
								'${3rd}/busted/library',
							}
						),
					},
				})
		end,
		---@type lspconfig.settings.lua_ls
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
					path = { 'lua/?.lua', 'lua/?/init.lua' },
				},
				diagnostics = {
					globals = { 'vim' },
				},
				workspace = {
					checkThirdParty = false,
					library = { vim.env.VIMRUNTIME },
				},
				format = { enable = false }, -- Disable formatting (formatting is done by stylua)
			},
		},
	},
	yamlls = {
		settings = {
			yaml = {
				schemaStore = {
					enable = false,
					url = '',
				},
				schemas = schemastore.yaml.schemas(),
			},
		},
	},
	jsonls = {
		---@type lspconfig.settings.jsonls
		settings = {
			json = {
				schemas = schemastore.json.schemas(),
				validate = { enable = true },
			},
		},
	},
	nil_ls = {},
}

-- List of formatters to install
local formatters = {
	'stylua', -- Used to format Lua code
	'prettier',
	'prettierd',
	'markdownlint',
	'nixfmt',
	'emmet-language-server',
}

-- List of linters to install
local linters = {
	'cspell',
	'markdownlint',
}

-- Can be opened with :Mason
require('mason').setup()
require('mason-lspconfig').setup()

-- Make sure everything configured above is installed
local ensure_installed = vim.tbl_keys(lsp_configs or {})
vim.list_extend(ensure_installed, formatters)
vim.list_extend(ensure_installed, linters)
require('mason-tool-installer').setup {
	ensure_installed = ensure_installed,
}

for name, server in pairs(lsp_configs) do
	vim.lsp.config(name, server)
	vim.lsp.enable(name)
end
