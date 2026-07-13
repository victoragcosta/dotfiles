-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Show mode because I like it
vim.opt.showmode = true

-- Always show tabline because I like it
vim.o.showtabline = 2

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history between sessions
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars =
	{ tab = '| ', trail = '·', nbsp = '␣', leadmultispace = '>-' }
-- Set indentations to tabs with size 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Adds \n to the end of the file
vim.opt.fileformat = 'unix'
vim.opt.fixendofline = true
vim.opt.fixeol = true

-- Enables editorconfig
vim.g.editorconfig = true

-- Let me know when I'm reaching the limit column
vim.opt_global.colorcolumn = { 81, '+1' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- Better colors for terminal
vim.opt.termguicolors = true

-- Set what will be saved in sessions
vim.opt.sessionoptions = table.concat({
	'buffers', -- all buffers, including hidden or unloaded
	'curdir', -- the current directory (also saves session in curdir)
	'folds', -- manual folds and fold states
	'help', -- opened help pages
	'tabpages', -- all tabs
	'terminal', -- all open terminals
	'winsize', -- the window configuration for each tab, including size
}, ',')

-- Syntax coloring for .env files
vim.filetype.add {
	pattern = {
		['.*.env.*.local'] = 'sh',
	},
}

-- Custom configurations
if not vim.g.victoragc then
	vim.g.victoragc = {
		autocwd_on_startup = true,
		notify_cwd_change = false,
	}
end
