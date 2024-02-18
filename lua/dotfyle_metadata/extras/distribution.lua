---The supported distributions
local supported_distributions = {
  astro_nvim = {
    -- module: https://github.com/AstroNvim/AstroNvim/tree/main/lua/astronvim/utils
    import = "astronvim.utils",
    name = "AstroNvim"
  },
  nv_chad = {
    -- module: https://github.com/NvChad/NvChad/tree/v2.0/lua/core
    import = "nvchad.core",
    name = "NvChad"
  },
  lunar_vim = {
    -- module: https://github.com/LunarVim/LunarVim/tree/master/lua/lvim/core
    import = "lvim.core",
    name = "LunarVim"
  },
}

---Get the nvim distro and return the name, or return custom
---@return string
return function()
  -- iterate over the supported distros and check if the import is found
  for key, _ in pairs(supported_distributions) do
    local distro = supported_distributions[key]
    if pcall(require, distro.import) then
      return supported_distributions[key].name
    end
  end

  -- If no distro is found, return custom
  return "custom"
end
