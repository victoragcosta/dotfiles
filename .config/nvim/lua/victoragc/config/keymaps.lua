-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set(
	'n',
	'<Esc>',
	'<cmd>nohlsearch<CR>',
	{ desc = 'Clear highlights' }
)

-- Diagnostic keymaps
vim.keymap.set(
	'n',
	'[d',
	vim.diagnostic.goto_prev,
	{ desc = 'Go to previous [D]iagnostic message' }
)
vim.keymap.set(
	'n',
	']d',
	vim.diagnostic.goto_next,
	{ desc = 'Go to next [D]iagnostic message' }
)
vim.keymap.set(
	'n',
	'<leader>e',
	vim.diagnostic.open_float,
	{ desc = 'Show diagnostic [E]rror messages' }
)
-- Now I'm using trouble for this
-- vim.keymap.set(
-- 	'n',
-- 	'<leader>q',
-- 	vim.diagnostic.setloclist,
-- 	{ desc = 'Open diagnostic [Q]uickfix list' }
-- )

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set(
	't',
	'<Esc><Esc>',
	'<C-\\><C-n>',
	{ desc = 'Exit terminal mode' }
)
vim.keymap.set('t', 'fjfj', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make buffer and split navigation and creation easier.

-- Use <Tab> and <Shift>+<Tab> to change buffers quickly
vim.keymap.set('n', '<Tab>', '<Cmd>bn<CR>', { desc = 'Go to next buffer' })
vim.keymap.set(
	'n',
	'<S-Tab>',
	'<Cmd>bp<CR>',
	{ desc = 'Go to previous buffer' }
)
-- gt for next tab
-- gT for previous tab
vim.keymap.set('n', '<C-t>', '<Cmd>tabnew<CR>', { desc = 'Create a new tab' })
vim.keymap.set('n', '<C-x>', '<Cmd>tabc<CR>', { desc = 'Close current tab' })

-- Use <leader>b to create new buffers easily and <leader>bd to close buffers
vim.keymap.set(
	'n',
	'<leader>dn',
	'<Cmd>enew<CR>',
	{ desc = '[D]ocument buffer [n]ew' }
)
vim.keymap.set(
	'n',
	'<leader>dc',
	'<Cmd>lua MiniBufremove.delete()<CR>',
	{ desc = '[D]ocument buffer [c]lose' }
)
vim.keymap.set(
	'n',
	'<leader>d!c',
	'<Cmd>lua MiniBufremove.delete(nil, true)<CR>',
	{ desc = '[D]ocument [!]force buffer [c]lose' }
)
vim.keymap.set(
	'n',
	'<leader>dl',
	'<Cmd>bn<CR>',
	{ desc = '[D]ocument go to next(l) buffer' }
)
vim.keymap.set(
	'n',
	'<leader>dh',
	'<Cmd>bp<CR>',
	{ desc = '[D]ocument go to previous(h) buffer' }
)

--  Use <leader>+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set(
	'n',
	'<leader>h',
	'<Cmd>wincmd h<CR>',
	{ desc = 'Move focus to the left window' }
)
vim.keymap.set(
	'n',
	'<leader>l',
	'<Cmd>wincmd l<CR>',
	{ desc = 'Move focus to the right window' }
)
vim.keymap.set(
	'n',
	'<leader>j',
	'<Cmd>wincmd j<CR>',
	{ desc = 'Move focus to the lower window' }
)
vim.keymap.set(
	'n',
	'<leader>k',
	'<Cmd>wincmd k<CR>',
	{ desc = 'Move focus to the upper window' }
)

-- Use <leader>+<+-> to split vertically or horizontally
vim.keymap.set(
	'n',
	'<leader>+',
	'<Cmd>vsplit<CR>',
	{ desc = 'Split the tab vertically' }
)
vim.keymap.set(
	'n',
	'<leader>-',
	'<Cmd>split<CR>',
	{ desc = 'Split the tab horizontally' }
)

-- Resize splits
vim.keymap.set('n', '<S-Left>', '<Cmd>vertical resize -2<CR>')
vim.keymap.set('n', '<S-Right>', '<Cmd>vertical resize +2<CR>')
vim.keymap.set('n', '<S-Up>', '<Cmd>resize +2<CR>')
vim.keymap.set('n', '<S-Down>', '<Cmd>resize -2<CR>')

-- Set visual block mode as a possible keychord due to widows terminal restrictions
vim.keymap.set('n', '<M-v>', '<C-v>', { desc = '[V]isual block mode' })

-- Move selected lines with alt arrows like in subl
vim.keymap.set(
	'v',
	'<A-k>',
	":m '<-2<CR>gv=gv",
	{ desc = 'Move selection up through lines' }
)
vim.keymap.set(
	'v',
	'<A-j>',
	":m '>+1<CR>gv=gv",
	{ desc = 'Move selection down through lines' }
)
vim.keymap.set(
	'n',
	'<A-k>',
	':m .-2<cr>==',
	{ desc = 'Move line up through lines' }
)
vim.keymap.set(
	'n',
	'<A-j>',
	':m .+1<cr>==',
	{ desc = 'Move line down through lines' }
)
