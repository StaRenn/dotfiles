require "nvchad.mappings"

local map = vim.keymap.set

-- Telescope mappings
map("n", "<leader>ff", "<cmd> Telescope find_files hidden=true <CR>", { desc = "Find files" })
map("n", "<leader>gb", "<cmd> Telescope git_branches <CR>", { desc = "Git branches" })

-- Conform mappings
map("n", "<leader>fm", "<cmd> Format <CR>", { desc = "Format" })

-- Multi cursor mappings
map("n", "<A-k>", ":call vm#commands#add_cursor_up(0, v:count1) <CR>", { desc = "Add cursor up" })
map("n", "<A-j>", ":call vm#commands#add_cursor_down(0, v:count1) <CR>", { desc = "Add cursor down" })

-- CopilotChat mappings (normal mode)
map("n", "<leader>ae", "<cmd>CopilotChatExplain<cr>", { desc = "CopilotChat - Explain code" })
map(
  "n",
  "<leader>at",
  ":CopilotChat Generate tests for current code, output only code, without explanation <cr>",
  { desc = "CopilotChat - Generate tests" }
)
map(
  "n",
  "<leader>ac",
  ":CopilotChat Review this code, how can i improve it? <cr>",
  { desc = "CopilotChat - Code review" }
)
map("n", "<leader>ar", ":CopilotChat Refactor this code <cr>", { desc = "CopilotChat - Refactor" })
map("n", "<leader>ad", ":CopilotChat Debug this code <cr>", { desc = "CopilotChat - Debug" })

-- CopilotChat mappings (visual mode)
map("x", "<leader>ax", ":CopilotChatInPlace<cr>", { desc = "CopilotChat - Run in-place code" })

-- DAP mappings
map("n", "<leader>rd", ":RustLsp debuggables <CR> 1 <CR>", { desc = "Dap debuggables" })
map("n", "<leader>rb", "<cmd> DapToggleBreakpoint <CR>", { desc = "Dap toggle breakpoint" })
map("n", "<leader>rc", ":lua require('dap').clear_breakpoints() <CR>", { desc = "Dap clear breakpoints" })
map("n", "<leader>ru", ":lua require('dapui').toggle()<CR>", { desc = "Toggle Dap UI" })
map("n", "<leader>rt", function()
  require("dap").terminate()
  require("dapui").close()
end, { desc = "Dap terminate" })

-- Diagnostics mappings
map("n", "]d", function()
  vim.diagnostic.goto_next()
  vim.diagnostic.open_float(nil)
end)

map("n", "[d", function()
  vim.diagnostic.goto_prev()
  vim.diagnostic.open_float(nil)
end)

map("n", "K", function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })

  if #diagnostics > 0 then
    vim.diagnostic.open_float(nil)
  else
    vim.lsp.buf.hover()
  end
end, { desc = "Hover with diagnostics priority" })

-- lsp
map("n", "ca", function()
  vim.lsp.buf.code_action()
end, { desc = "LSP Code Action" })

-- Fugitive mappings
map("n", "<leader>gg", "<cmd> Git <CR>", { desc = "Git status" })
map("n", "<leader>gc", "<cmd> Git commit <CR>", { desc = "Git commit" })
map("n", "<leader>gf", "<cmd> Git fetch <CR>", { desc = "Git fetch" })
map("n", "<leader>gp", "<cmd> Git push <CR>", { desc = "Git push" })
map("n", "<leader>ga", "<cmd> Gwrite <CR>", { desc = "Git add" })
map("n", "<leader>gd", "<cmd> Gvdiffsplit! <CR>", { desc = "Git fix merge conflict" })

-- Commented out neotest mappings for future use
-- map("n", "<leader>tr", ':lua require("neotest").run.run() <CR>', { desc = "Launch test" })
-- map("n", "<leader>ts", ':lua require("neotest").run.stop() <CR>', { desc = "Stop test" })
-- map("n", "<leader>to", ':lua require("neotest").output.open() <CR>', { desc = "Test output" })
-- map("n", "<leader>tO", ':lua require("neotest").output.open({enter = true}) <CR>', { desc = "Test output enter mode" })
-- map("n", "<leader>ti", ':lua require("neotest").summary.toggle() <CR>', { desc = "Test summary" })
-- map("n", "<leader>ta", ':lua require("neotest").playwright.attachment() <CR>', { desc = "Launch test attachment" })
