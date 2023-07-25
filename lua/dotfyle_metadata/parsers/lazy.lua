return {
	name = "lazy.nvim",

	installed = function()
		local loaded = pcall(require, "lazy")
		return loaded
	end,

	parse = function()
		local list = {}

		for _, plugin in pairs(require("lazy").plugins()) do
			table.insert(list, plugin[1])
		end

		return list
	end,
}
