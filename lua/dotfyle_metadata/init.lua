local uv = vim.loop
local get_plugins = require("dotfyle_metadata.plugins")
local get_mapleader = require("dotfyle_metadata.mapleader")
local get_keymaps = require("dotfyle_metadata.keymaps")
local get_servers = require("dotfyle_metadata.extras.lsp")
local get_distribution = require("dotfyle_metadata.extras.distribution")
local get_treesitter_parsers = require("dotfyle_metadata.extras.treesitter")
local get_mason_tools = require("dotfyle_metadata.extras.mason")

local M = {}

M.dotfyle_path = string.format("%s/dotfyle.json", vim.fn.stdpath("config"))

function M.generate(options)
	local plugin_manager, plugins = get_plugins()

  local metadata = {}
  metadata.leaderKey = get_mapleader()
  metadata.pluginManager = plugin_manager
  metadata.plugins = plugins
  metadata.lspServers = get_servers()
  metadata.masonTools = get_mason_tools()
  metadata.treesitterParsers = get_treesitter_parsers()
  metadata.distribution = get_distribution()

  if vim.tbl_contains(options, '--keymaps') then
    -- Opt-in to show keymaps, since it blows up the file size
    metadata.keymaps = get_keymaps()
  end

	local json = vim.fn.json_encode(metadata)

	local fd = assert(uv.fs_open(M.dotfyle_path, "w", 438))
	assert(uv.fs_write(fd, json))
	assert(uv.fs_close(fd))

	vim.notify("[dotfyle-metadata] json file generated, open with `:DotfyleOpen`", nil, nil)
end

return M
