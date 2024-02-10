local uv = vim.loop
local get_plugins = require("dotfyle_metadata.plugins")
local get_mapleader = require("dotfyle_metadata.mapleader")
local get_keymaps = require("dotfyle_metadata.keymaps")
local get_servers = require("dotfyle_metadata.extras.lsp")
local get_treesitter_parsers = require("dotfyle_metadata.extras.treesitter")
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
		["treesitterParsers"] = get_treesitter_parsers(),
	}

	local json = vim.fn.json_encode(dotfyle_ref)

	local fd = assert(uv.fs_open(M.dotfyle_path, "w", 438))
	assert(uv.fs_write(fd, json))
	assert(uv.fs_close(fd))

	vim.notify("[dotfyle-metadata] json file generated, open with `:DotfyleOpen`", nil, nil)
end

return M
