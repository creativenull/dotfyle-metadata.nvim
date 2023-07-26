local parsers = {
	require("dotfyle_metadata.plugins.plug"),
	require("dotfyle_metadata.plugins.packer"),
	require("dotfyle_metadata.plugins.lazy"),
	require("dotfyle_metadata.plugins.paq"),
	require("dotfyle_metadata.plugins.minpac"),
	require("dotfyle_metadata.plugins.dein"),
	require("dotfyle_metadata.plugins.vundle"),
}

return function()
	for _, p in pairs(parsers) do
		if p.installed() then
			return p.name, p.parse()
		end
	end

	-- default is unknown
	local unknown = require("dotfyle_metadata.plugins.unknown")
	return unknown.name, unknown.parse()
end
