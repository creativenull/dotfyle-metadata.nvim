if vim.g.loaded_dotfyle then
	return
end

local dotfyle = require("dotfyle")

vim.api.nvim_create_user_command("DotfyleGenerate", dotfyle.generate, { desc = "Generate a dotfyle.json file" })

vim.g.loaded_dotfyle = true
