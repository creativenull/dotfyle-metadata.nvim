local M = {}

local function has_vim_plug()
  return vim.fn.exists('*plug#begin') == 1
end

local function get_vim_plug_plugins()
  local list = {}

  for k,v in pairs(vim.g.plugs) do
    -- 'https://git::@github.com/username/repo.git'
    local name = v.uri:match("https?://.-/([^/]+/[^/]+).git")
    table.insert(list, name)
  end

  return list
end

local function has_packer()
  local loaded = pcall(require, 'packer')
  return loaded
end

local function get_packer_plugins()
  local list = {}

  for k,v in pairs(_G.packer_plugins) do
    -- 'https://github.com/username/repo'
    local name = v.url:match("https?://.-/([^/]+/[^/]+)")
    table.insert(list, name)
  end

  return list
end

local function has_lazy()
  local loaded = pcall(require, 'lazy')
  return loaded
end

local function get_lazy_plugins()
  local list = {}

  for k,v in pairs(require('lazy').plugins()) do
    table.insert(list, v[1])
  end

  return list
end

function M.generate()
	local leader = vim.g.mapleader
  local plugin_manager = 'unknown'
	local plugins = {}

  if has_vim_plug() then
    plugins = get_vim_plug_plugins()
    plugin_manager = 'vim-plug'
  elseif has_packer() then
    plugins = get_packer_plugins()
    plugin_manager = 'packer.nvim'
  elseif has_lazy() then
    plugins = get_lazy_plugins()
    plugin_manager = 'lazy.nvim'
  end

	local dotfyle_ref = {
		leaderKey = leader,
    pluginManager = plugin_manager,
		plugins = plugins,
	}

	local json = vim.json.encode(dotfyle_ref)

	vim.fn.writefile({ json }, string.format('%s/dotfyle.json', vim.fn.stdpath('config')))
end

return M
