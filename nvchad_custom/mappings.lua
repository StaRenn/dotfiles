---@type MappingsTable
local M = {}

M.telescope = {
  n = {
    ["<leader>gb"] = { "<cmd> Telescope git_branches <CR>", "Git branches" },
  },
}

M.leap = {
  n = {
    ["<leader>s"] = { "<Plug>(leap-forward)", "Leap forward" },
    ["<leader>a"] = { "<Plug>(leap-backward)", "Leap backward" }
  }
}

M.neotest = {
  n = {
    ["<leader>tr"] = { ':lua require("neotest").run.run() <CR>', "Launch test"},
    ["<leader>ts"] = { ':lua require("neotest").run.stop() <CR>', "Stop test"},
    ["<leader>to"] = { ':lua require("neotest").output.open() <CR>', "Test output"},
    ["<leader>tO"] = { ':lua require("neotest").output.open({enter = true}) <CR>', "Test output enter mode"},
    ["<leader>ti"] = { ':lua require("neotest").summary.toggle() <CR>', "Test summary"},
  }
}

M.neotestPlaywright = {
  n = {
    ["<leader>ta"] = { ':lua require("neotest").playwright.attachment() <CR>', "Launch test attachment"}
  }
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
