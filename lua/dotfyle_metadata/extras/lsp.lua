---Get the user configured lsp servers
---@return table
return function()
	local loaded, lspconfig = pcall(require, "lspconfig")

	if not loaded then
		return {}
	end

	local servers

	if lspconfig.util._available_servers ~= nil then
		servers = lspconfig.util._available_servers()
	else
		servers = lspconfig.util.available_servers()
	end

	-- sort the plugins A-Za-z
	table.sort(servers)

	return servers
end
