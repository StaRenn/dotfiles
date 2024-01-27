---@type MappingsTable
local M = {}

M.telescope = {
  n = {
    ["<leader>gb"] = { "<cmd> Telescope git_branches <CR>", "Git branches" },
  },
}

M.conform = {
  n = {
    ["<leader>fm"] = { "<cmd> Format <CR>", "Format" },
  },
}

M.multi = {
  n = {
    ["<A-k>"] = { ":call vm#commands#add_cursor_up(0, v:count1) <CR>", "Add cursor up" },
    ["<A-j>"] = { ":call vm#commands#add_cursor_down(0, v:count1) <CR>", "Add cursor down" },
  },
}

M.dap = {
  n = {
    ["<leader>rd"] = { ":RustLsp debuggables <CR> 1 <CR>", "Dap debuggables" },
    ["<leader>rb"] = { "<cmd> DapToggleBreakpoint <CR>", "Dap toggle breakpoint" },
    ["<leader>rc"] = { ":lua require('dap').clear_breakpoints() <CR>", "Dap clear breakpoints" },
    ["<leader>ru"] = { ":lua require('dapui').toggle()<CR>", "Toggle Dap UI" },
    ["<leader>rt"] = {
      function()
        require("dap").terminate()
        require("dapui").close()
      end,
      "Dap terminate",
    },
  },
}

M.leap = {
  n = {
    ["<leader>s"] = { "<Plug>(leap-forward)", "Leap forward" },
    ["<leader>a"] = { "<Plug>(leap-backward)", "Leap backward" },
  },
}

-- later
-- M.neotest = {
--   n = {
--     ["<leader>tr"] = { ':lua require("neotest").run.run() <CR>', "Launch test" },
--     ["<leader>ts"] = { ':lua require("neotest").run.stop() <CR>', "Stop test" },
--     ["<leader>to"] = { ':lua require("neotest").output.open() <CR>', "Test output" },
--     ["<leader>tO"] = { ':lua require("neotest").output.open({enter = true}) <CR>', "Test output enter mode" },
--     ["<leader>ti"] = { ':lua require("neotest").summary.toggle() <CR>', "Test summary" },
--   },
-- }
--
-- M.neotestPlaywright = {
--   n = {
--     ["<leader>ta"] = { ':lua require("neotest").playwright.attachment() <CR>', "Launch test attachment" },
--   },
-- }

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

M.other = {
  n = {
    ["K"] = { ":lua vim.lsp.buf.hover() <CR>", "LSP hover" },
    ["<leader>ra"] = { ':lua require("nvchad.renamer").open() <CR>', "LSP rename" },
  },
}

return M
