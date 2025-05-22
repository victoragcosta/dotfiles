-- Configs --
vim.g.firenvim_config = {
	globalSettings = { alt = 'all' },
	localSettings = {
		['.*'] = {
			cmdline = 'neovim',
			content = 'text',
			priority = 0,
			selector = 'textarea',
			takeover = 'never',
		},
	},
}

vim.api.nvim_create_autocmd({ 'UIEnter' }, {
	callback = function(event)
		local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
		if client ~= nil and client.name == 'Firenvim' then
			-- Configs
			-- Set minimal width and height
			if vim.o.lines < 40 then
				vim.o.lines = 40
			end
			if vim.o.columns < 80 then
				vim.o.columns = 80
			end
			-- Set font for the GUI
			vim.o.guifont = 'FiraCode Nerd Font Mono'

			-- Keymaps --
			vim.keymap.set('n', '<Esc><Esc>', '<Cmd>call firenvim#focus_page()<CR>')

			-- Autocommands --

			-- Automatically infer filetypes
			local autofiletype_group = vim.api.nvim_create_augroup(
				'victoragc-autofiletype-firenvim',
				{ clear = true }
			)
			vim.api.nvim_create_autocmd('BufEnter', {
				desc = "Infer svelte filetype for svelte's REPL",
				pattern = 'svelte.dev_*.txt',
				group = autofiletype_group,
				callback = function()
					vim.bo.filetype = 'svelte'
				end,
			})

			-- -- Automatically sync textarea with buffer when in firenvim
			-- local firenvim_group =
			-- 	vim.api.nvim_create_augroup('victoragc-firenvim', { clear = true })
			--
			-- vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
			-- 	group = firenvim_group,
			-- 	callback = function()
			-- 		if vim.g.timer_started == true then
			-- 			return
			-- 		end
			-- 		vim.g.timer_started = true
			-- 		vim.fn.timer_start(10000, function()
			-- 			vim.g.timer_started = false
			-- 			vim.cmd.write()
			-- 		end)
			-- 	end,
			-- })
		end
	end,
})
