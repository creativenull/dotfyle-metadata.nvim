---Get the installed treesitter parsers by nvim-treesitter
---@return table
return function()
	local loaded, ts = pcall(require, "nvim-treesitter.configs")

	if not loaded then
		return {}
	end

	local parsers = ts.get_ensure_installed_parsers()

	-- sort the plugins A-Za-z
	table.sort(parsers)

	return parsers
end
