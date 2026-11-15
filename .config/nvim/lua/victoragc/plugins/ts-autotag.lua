require 'url'

vim.pack.add {
	github 'tronikelis/ts-autotag.nvim',
}

require('ts-autotag').setup {
	auto_close = {
		enabled = true,
	},
	filetypes = {
		'typescript',
		'javascript',
		'typescriptreact',
		'javascriptreact',
		'svelte',
		'xml',
		'html',
		'templ',
		'php',
	},
	auto_rename = {
		enabled = true,
	},
}
