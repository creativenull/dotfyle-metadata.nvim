local Distribution = {
  AstroNvim = "AstroNvim",
  NvChad = "NvChad",
  LunarNvim = "LunarNvim",
  Unknown = "Unknown"
}

---Get the nvim distro
---@return string
return function()
  local astronvim = pcall(require, "astronvim");
  if astronvim ~= nil then
    return Distribution.AstroNvim
  end

  local nvchad = pcall(require, "nvchad");
  if nvchad ~= nil then
    return Distribution.NvChad
  end

  local lunarnvim = pcall(require, "lunarnvim");
  if lunarnvim ~= nil then
    return Distribution.LunarNvim
  end

  return Distribution.Unknown
end
