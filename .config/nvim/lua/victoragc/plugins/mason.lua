---@type (string | LazyPluginSpec)[]
local plugins = {

	{
		'williamboman/mason.nvim',
		event = 'VeryLazy',
		dependencies = {
			'WhoIsSethDaniel/mason-tool-installer.nvim',
			'williamboman/mason-lspconfig.nvim',
			'jay-babu/mason-nvim-dap.nvim',
			'b0o/schemastore.nvim',
		},
		config = function()
			-- Can be opened with :Mason
			require('mason').setup()

			-- Enable the following language servers
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local schemastore = require 'schemastore'
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
				tsserver = {},
				svelte = {
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
					settings = {
						eslint = {
							-- useFlatConfig = true,
						},
					},
				},
				-- graphql = {},
				relay_lsp = {
					cmd = { 'pnpm', 'exec', 'relay-compiler', 'lsp' },
				},

				-- Other languages
				rust_analyzer = {},
				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = 'Replace',
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
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
					settings = {
						json = {
							schemas = schemastore.json.schemas(),
							validate = { enable = true },
						},
					},
				},
			}

			-- List of debug adapters to install
			local dap_configs = {}

			-- List of formatters to install
			local formatters = {
				'stylua', -- Used to format Lua code
				'prettier',
				'prettierd',
				'markdownlint',
			}

			-- List of linters to install
			local linters = {
				'cspell',
				'markdownlint',
			}

			-- Make sure everything configured above is installed
			local ensure_installed = vim.tbl_keys(lsp_configs or {})
			local daps = vim.tbl_keys(dap_configs or {})
			vim.list_extend(ensure_installed, daps)
			vim.list_extend(ensure_installed, formatters)
			vim.list_extend(ensure_installed, linters)
			require('mason-tool-installer').setup {
				ensure_installed = ensure_installed,
			}

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend(
				'force',
				capabilities,
				require('cmp_nvim_lsp').default_capabilities()
			)

			local setup_lsp = function(server_name)
				local server = lsp_configs[server_name] or {}
				-- This handles overriding only values explicitly passed
				-- by the server configuration above. Useful when disabling
				-- certain features of an LSP (for example, turning off formatting for tsserver)
				server.capabilities = vim.tbl_deep_extend(
					'force',
					{},
					capabilities,
					server.capabilities or {}
				)
				require('lspconfig')[server_name].setup(server)
			end
			require('mason-lspconfig').setup {
				handlers = {
					setup_lsp,
				},
			}
			-- Manually setup non mason lsps
			setup_lsp 'relay_lsp'

			require('mason-nvim-dap').setup {
				automatic_installation = false,
				handlers = {},
				ensure_installed = {},
			}
		end,
	},
}

return plugins
