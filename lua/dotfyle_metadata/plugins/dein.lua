return {
	name = "dein.vim",

	installed = function()
		return vim.fn.exists("*dein#begin") == 1
	end,

	parse = function()
		return vim.tbl_map(function(plugin)
			return plugin.repo
		end, vim.tbl_values(vim.g["dein#_plugins"]))
	end,
}
