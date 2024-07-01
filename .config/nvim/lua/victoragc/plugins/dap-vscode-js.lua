---@type (string|LazyPluginSpec)[]
local plugins = {
	{
		'mxsdev/nvim-dap-vscode-js',
		dependencies = {
			'mfussenegger/nvim-dap',
			{
				'microsoft/vscode-js-debug',
				-- NOTE: Disable debuggers for textarea editors in the browser (it makes no sense using them)
				enabled = not vim.g.started_by_firenvim,
				build = 'npm install --legacy-peer-deps'
					.. ' && npx gulp vsDebugServerBundle'
					.. ' && mv dist out '
					.. ' && git restore package-lock.json',
			},
		},
		config = function()
			local js_dap_languages = {
				'typescript',
				'javascript',
				'typescriptreact',
				'javascriptreact',
				'svelte',
				-- 'vue',
			}

			for _, language in ipairs(js_dap_languages) do
				---@diagnostic disable-next-line: missing-fields
				require('dap-vscode-js').setup {
					-- Path of node executable. Defaults to $NODE_PATH, and then "node"
					node_path = '/home/victor/.asdf/shims/node',

					-- Path to vscode-js-debug installation.
					debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug',

					-- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
					-- debugger_cmd = { "js-debug-adapter" },

					-- which adapters to register in nvim-dap
					adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal' },

					-- Path for file logging
					-- log_file_path = "(stdpath cache)/dap_vscode_js.log"

					-- Logging level for output to file. Set to false to disable file logging.
					-- log_file_level = false

					-- Logging level for output to console. Set to false to disable console output.
					-- log_console_level = vim.log.levels.ERROR
				}

				require('dap').configurations[language] = {
					{
						type = 'pwa-node',
						request = 'launch',
						name = 'Launch file',
						program = '${file}',
						cwd = '${workspaceFolder}',
					},
					{
						type = 'pwa-node',
						request = 'attach',
						name = 'Attach',
						processId = require('dap.utils').pick_process,
						cwd = '${workspaceFolder}',
					},
					{
						type = 'pwa-chrome',
						request = 'launch',
						name = 'Launch & Debug Chrome',
						url = function()
							local co = coroutine.running()
							return coroutine.create(function()
								vim.ui.input({
									prompt = 'Enter URL: ',
									default = 'http://localhost:4000',
								}, function(url)
									if url == nil or url == '' then
										return
									else
										coroutine.resume(co, url)
									end
								end)
							end)
						end,
					},
				}
			end
		end,
	},
}

return plugins
