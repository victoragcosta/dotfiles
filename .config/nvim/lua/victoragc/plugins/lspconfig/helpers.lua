---@type table<string,function>
local helpers = {}

helpers.create_keymapper = function(buf)
	return function(keys, func, desc)
		vim.keymap.set('n', keys, func, { buffer = buf, desc = 'LSP: ' .. desc })
	end
end

return helpers
