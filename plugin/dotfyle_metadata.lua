if vim.g.loaded_dotfyle_metadata then
	return
end

local dm = require("dotfyle_metadata")
vim.api.nvim_create_user_command("DotfyleGenerate", dm.generate, { desc = "Generate a dotfyle.json file" })
vim.api.nvim_create_user_command(
	"DotfyleOpen",
	string.format("edit %s", dm.dotfyle_path),
	{ desc = "Open the dotfyle.json file" }
)

vim.g.loaded_dotfyle_metadata = true
