return {
	name = "paq-nvim",

	installed = function()
		local loaded = pcall(require, "paq")
		return loaded
	end,

	parse = function()
		vim.cmd([[
      redir => g:paq_plugins
      PaqList
      redir END
    ]])

		local plugin_iter = vim.gsplit(vim.g.paq_plugins, "\n", { plain = true, trimempty = true })
		local plugins = {}

		for k in plugin_iter do
			if not vim.startswith(k, "Installed") then
				table.insert(plugins, k)
			end
		end

		vim.g.paq_plugins = vim.tbl_map(function(item) return vim.trim(item) end, plugins)

		return vim.g.paq_plugins
	end,
}
