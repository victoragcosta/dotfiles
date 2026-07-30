require 'url'

vim.pack.add { github 'catgoose/nvim-colorizer.lua' }

-- Enable all CSS color formats
require('colorizer').setup {
	options = { parsers = { css = true } },
}
