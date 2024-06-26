local enable_providers = {
	"python3_provider",
}

for _, plugin in pairs(enable_providers) do
	vim.g["loaded_" .. plugin] = nil
	vim.cmd("runtime " .. plugin)
end

vim.api.nvim_create_user_command("Format", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { range = true })

vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.autoread = true

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
vim.g.copilot_filetypes = { markdown = true }
