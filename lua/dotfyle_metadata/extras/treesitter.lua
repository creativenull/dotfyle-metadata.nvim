---Get the installed treesitter parsers by nvim-treesitter
---@return table
return function()
	local loaded, ts = pcall(require, "nvim-treesitter.configs")

	if not loaded then
		return {}
	end

	return ts.get_ensure_installed_parsers()
end
