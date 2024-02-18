local Distribution = {
  AstroNvim = "AstroNvim",
  NvChad = "NvChad",
  LunarVim = "LunarVim",
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

  local lunarvim = pcall(require, "lunarvim");
  if lunarvim ~= nil then
    return Distribution.LunarVim
  end

  return Distribution.Unknown
end
