-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "onedark",
}

M.nvdash = { load_on_startup = true }

M.ui = {
  colorify = {
    enabled = true,
    mode = "bg",
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
  },
}

return M
