require 'url'

vim.pack.add {
	github 'lindmeira/arduino.nvim',
}

require('arduino').setup {
	serial_baud = 57600,
}
