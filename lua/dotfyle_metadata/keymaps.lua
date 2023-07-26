---Get all user defined keymaps
---@return table
return function()
	local keymaps = {}
	local global_keymaps = vim.api.nvim_get_keymap("")

	for _, map in pairs(global_keymaps) do
		-- translate the strings into something usable by :map
		map.lhs = vim.api.nvim_replace_termcodes(map.lhs, true, true, false)

		if map.rhs == "" then
			-- replace the empty string with empty modifier
			map.rhs = "<Nop>"
		end

		if map.callback then
			-- check if the mapping is a function
			-- HACK: can't encode a function
			-- but we should probably write out what it does
			map.callback = "function"
		end

		table.insert(keymaps, {
			mode = map.mode,
			lhs = map.lhs,
			rhs = map.rhs,
			desc = map.desc == nil and "" or map.desc,
			noremap = map.noremap == 1,
		})
	end

	return keymaps
end
