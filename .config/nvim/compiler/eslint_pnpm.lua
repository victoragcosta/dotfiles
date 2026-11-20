-- Prevent duplicate loading
if vim.g.current_compiler == 'eslint_pnpm' then
	return
end
vim.g.current_compiler = 'eslint_pnpm'

vim.cmd [[CompilerSet makeprg=pnpm\ lint:eslint\ --format\ compact]]
vim.cmd [[CompilerSet errorformat=%f:\ line\ %l\,\ col\ %c\,\ %t%*[^\ ]\ -\ %m]]
