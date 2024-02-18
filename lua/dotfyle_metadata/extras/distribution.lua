local Distribution = {
  AstroNvim = "AstroNvim",
  NvChad = "NvChad",
  LunarVim = "LunarVim",
  Unknown = "Unknown"
}

---Get the nvim distro
---@return string
return function()
  local loaded

  loaded, _ = pcall(require, "astronvim");
  if loaded then
    return Distribution.AstroNvim
  end

  loaded = pcall(require, "nvchad");
  if loaded then
    return Distribution.NvChad
  end

  loaded = pcall(require, "lunarvim");
  if loaded then
    return Distribution.LunarVim
  end

  return Distribution.Unknown
end
