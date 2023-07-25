return {
	name = "Vundle.vim",

	installed = function()
		return vim.fn.exists("*vundle#begin") == 1
	end,

	parse = function()
		return vim.tbl_map(function(plugin)
			return plugin.name_spec
		end, vim.tbl_values(vim.g['vundle#bundles']))
	end,
}
