---Get the user configured lsp servers
---@return table
return function()
	local loaded, lspconfig = pcall(require, "lspconfig")

	if not loaded then
		return {}
	end

	local servers = lspconfig.util.available_servers()

	-- sort the plugins A-Za-z
	table.sort(servers)

	return servers
end
