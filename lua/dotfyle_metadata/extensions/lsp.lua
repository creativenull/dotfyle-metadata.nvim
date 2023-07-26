return function()
  local loaded, lspconfig = pcall(require, 'lspconfig')

  if not loaded then
    return {}
  end

  return lspconfig.util.available_servers()
end
