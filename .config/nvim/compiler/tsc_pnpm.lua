-- Prevent duplicate loading
if vim.g.current_compiler == 'tsc_pnpm' then
	return
end
vim.g.current_compiler = 'tsc_pnpm'

vim.cmd [[CompilerSet makeprg=pnpm\ type-check]]
vim.cmd [[CompilerSet errorformat=%f\ %#(%l\\,%c):\ %trror\ TS%n:\ %m,
		       \%trror\ TS%n:\ %m,
		       \%-G%.%#]]
