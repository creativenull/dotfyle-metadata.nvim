local supported_distributions = {
	AstroNvim = {
		is_detected = function()
			local astrov3_loaded, _ = pcall(require, "astronvim")
			local astrov4_loaded, _ = pcall(require, "astrocore")

			return astrov3_loaded or astrov4_loaded
		end,
	},
	NvChad = {
		is_detected = function()
			return pcall(require, "nvchad")
		end,
	},
	LunarVim = {
		is_detected = function()
			return pcall(require, "lunarvim")
		end,
	},
}

---Get the nvim distro and return the name, or return custom
---@return string
return function()
	-- iterate over the supported distros and check if the import is found
	for k, distro in pairs(supported_distributions) do
		if distro.is_detected() then
			return k
		end
	end

	-- If no distro is found, return custom
	return "custom"
end
