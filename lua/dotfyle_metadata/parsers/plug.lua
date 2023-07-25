return {
	name = "vim-plug",

	installed = function()
		return vim.fn.exists("*plug#begin") == 1
	end,

	parse = function()
		return vim.tbl_map(function(plugin)
			-- 'https://git::@github.com/username/repo.git'
			return plugin.uri:match("https?://.-/([^/]+/[^/]+).git")
		end, vim.g.plugs)
	end,
}
