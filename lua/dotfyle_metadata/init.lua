local get_plugins = require("dotfyle_metadata.plugins")
local get_mapleader = require("dotfyle_metadata.mapleader")
local get_keymaps = require("dotfyle_metadata.keymaps")
local get_servers = require("dotfyle_metadata.extras.lsp")
local get_mason_tools = require("dotfyle_metadata.extras.mason")

local M = {}

M.dotfyle_path = string.format("%s/dotfyle.json", vim.fn.stdpath("config"))

function M.generate()
	local plugin_manager, plugins = get_plugins()

	-- Json structure
	local dotfyle_ref = {
		["leaderKey"] = get_mapleader(),
		["pluginManager"] = plugin_manager,
		["plugins"] = plugins,
		["keymaps"] = get_keymaps(),
		["lspServers"] = get_servers(),
		["masonTools"] = get_mason_tools(),
	}

	local json = vim.json.encode(dotfyle_ref)
	vim.fn.writefile({ json }, M.dotfyle_path)

	vim.notify("[dotfyle-metadata] json file generated, open with `:DotfyleOpen`", nil, nil)
end

return M
