local get_mapleader = require("dotfyle_metadata.extensions.mapleader")
local get_keymaps = require("dotfyle_metadata.extensions.keymaps")
local get_servers = require("dotfyle_metadata.extensions.lsp")

local M = {}

local dotfyle_path = string.format("%s/dotfyle.json", vim.fn.stdpath("config"))

local parsers = {
	require("dotfyle_metadata.parsers.plug"),
	require("dotfyle_metadata.parsers.packer"),
	require("dotfyle_metadata.parsers.lazy"),
	require("dotfyle_metadata.parsers.paq"),
	require("dotfyle_metadata.parsers.minpac"),
	require("dotfyle_metadata.parsers.dein"),
	require("dotfyle_metadata.parsers.vundle"),
}

local function get_plugins_info()
	for _, p in pairs(parsers) do
		if p.installed() then
			return p.name, p.parse()
		end
	end

	-- default is unknown
	local unknown = require("dotfyle_metadata.parsers.unknown")
	return unknown.name, unknown.parse()
end

function M.generate()
	local plugin_manager, plugins = get_plugins_info()

	-- Json structure
	local dotfyle_ref = {
		["leaderKey"] = get_mapleader(),
		["pluginManager"] = plugin_manager,
		["plugins"] = plugins,
		["keymaps"] = get_keymaps(),
		["lspServers"] = get_servers(),
	}

	local json = vim.json.encode(dotfyle_ref)
	vim.fn.writefile({ json }, dotfyle_path)

	vim.notify("[dotfyle] dotfyle.json generated!", nil, nil)
	vim.cmd(string.format("edit %s", dotfyle_path))

	-- TODO: Try something else instead of this complexity
	if vim.fn.executable("jq") == 1 then
		vim.cmd("%!jq")
		vim.cmd("write")
	elseif vim.fn.executable("prettier") == 1 then
		vim.cmd("%!prettier --no-color --stdin --stdin-filepath %")
		vim.cmd("write")
	elseif vim.fn.has("python3") == 1 then
		vim.cmd("%!python3 -m json.tool")
		vim.cmd("write")
	end
end

return M
