-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight",
}

M.ui = {
  statusline = {
    theme = "vscode_colored",
    separator_style = "block",
    overriden_modules = nil,
  },
}

return M
