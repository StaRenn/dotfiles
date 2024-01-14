---@type MappingsTable
local M = {}

M.telescope = {
  n = {
    ["<leader>gb"] = { "<cmd> Telescope git_branches <CR>", "Git branches" },
  },
}

M.fugitive = {
  n = {
    ["<leader>gg"] = { "<cmd> Git <CR>", "Git status" },
    ["<leader>gc"] = { "<cmd> Git commit <CR>", "Git commit" },
    ["<leader>gf"] = { "<cmd> Git fetch <CR>", "Git fetch" },
    ["<leader>gp"] = { "<cmd> Git push <CR>", "Git push" },
    ["<leader>ga"] = { "<cmd> Gwrite <CR>", "Git add" },
    ["<leader>gd"] = { "<cmd> Gvdiffsplit! <CR>", "Git fix merge conflict" },
  },
}

return M
