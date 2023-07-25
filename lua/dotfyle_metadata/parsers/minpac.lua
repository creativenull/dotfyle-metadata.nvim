return {
	name = "minpac",

	installed = function()
		return vim.fn.exists("*minpac#init") == 1
	end,

	parse = function()
		return vim.tbl_map(function(plugin)
			return plugin.url:match("https?://.-/([^/]+/[^/]+).git")
		end, vim.tbl_values(vim.call("minpac#getpluglist")))
	end,
}
