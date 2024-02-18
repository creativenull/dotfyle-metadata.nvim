local parsers = {
	require("dotfyle_metadata.plugins.plug"),
	require("dotfyle_metadata.plugins.packer"),
	require("dotfyle_metadata.plugins.lazy"),
	require("dotfyle_metadata.plugins.paq"),
	require("dotfyle_metadata.plugins.minpac"),
	require("dotfyle_metadata.plugins.dein"),
	require("dotfyle_metadata.plugins.vundle"),
}

---Check the user installed plugin manager and get
---list of installed plugins
---@return string, table
return function()
	for _, p in pairs(parsers) do
		if p.installed() then
			local plugins = p.parse()
			-- sort the plugins A-Za-z
			table.sort(plugins)

			return p.name, plugins
		end
	end

	-- default is unknown
	local unknown = require("dotfyle_metadata.plugins.unknown")
	return unknown.name, unknown.parse()
end
