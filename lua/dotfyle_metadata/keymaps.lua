---Get all user defined keymaps
---@return table

local function check_map(keymap)
	-- check if the mapping is one we want to include

	if
		keymap.mode ~= "n"
		and keymap.mode ~= "i"
		and keymap.mode ~= "x"
		and keymap.mode ~= "v"
		and keymap.mode ~= "t"
	then
		return false
	end
	if string.find(keymap.lhs, "<Plug>") then
		return false
	end

	return true
end

return function()
	local keymaps = {}
	local global_keymaps = vim.api.nvim_get_keymap("")

	for _, map in pairs(global_keymaps) do
		-- translate the strings into something usable by :map
		map.lhs = vim.fn.maparg(map.lhsraw, map.mode, false, true).lhs

		if map.callback then
			-- check if the mapping is a function
			-- HACK: can't encode a function
			-- but we should probably write out what it does
			map.rhs = "<function>"
		elseif map.rhs == "" then
			-- replace the empty string with empty modifier
			map.rhs = "<Nop>"
		end

		if check_map(map) then
			table.insert(keymaps, {
				mode = map.mode,
				lhs = map.lhs,
				rhs = map.rhs,
				desc = map.desc == nil and "" or map.desc,
				noremap = map.noremap == 1,
			})
		end
	end

	return keymaps
end
