require 'url'

vim.pack.add({
	{ src = github 'saghen/blink.cmp', version = vim.version.range '1.*' },
	{ src = github 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' },
	github 'barrettruth/blink-cmp-ghostty',
})

require('luasnip').setup()
require('blink.cmp').setup({
keymap= {
		preset = 'default',
				-- Select the next item with j as in going down
				['<C-j>'] = {'select_next', 'fallback'},
				-- Select the previous item with k as in going up
				['<C-k>'] = {'select_prev', 'fallback'},

				-- Scroll the documentation window [b]ack / [f]orward
				['<C-b>'] = {'scroll_documentation_up', 'fallback'},
				['<C-f>'] = {'scroll_documentation_down', 'fallback'},

				-- ['<C-l>'] = cmp.mapping(function()
				-- 	if luasnip.expand_or_locally_jumpable() then
				-- 		luasnip.expand_or_jump()
				-- 	end
				-- end, { 'i', 's' }),
				-- ['<C-h>'] = cmp.mapping(function()
				-- 	if luasnip.locally_jumpable(-1) then
				-- 		luasnip.jump(-1)
				-- 	end
				-- end, { 'i', 's' }),
	},
	appearance = {
		nerd_font_variant = 'mono'
	},
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500},
		menu = {draw = { columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },}}
	},
	sources = {
		default = { 'lsp', 'path', 'snippets', 'path', 'ghostty' },
		providers = {
			ghostty = {
				name = 'Ghostty',
				module = 'blink-cmp-ghostty',
			},
		},
	},
	snippets = {
		preset = 'luasnip',
	},
	fuzzy = {
		implementation = 'prefer_rust_with_warning',
	},
	signature = { enabled = true },
})

