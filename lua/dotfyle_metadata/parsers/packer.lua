return {
	name = "packer.nvim",

	installed = function()
		local loaded = pcall(require, "packer")
		return loaded
	end,

	parse = function()
		return vim.tbl_map(function(plugin)
			-- 'https://github.com/username/repo'
      return plugin.url:match("https?://.-/([^/]+/[^/]+)")
		end, vim.tbl_values(_G.packer_plugins))
	end,
}
