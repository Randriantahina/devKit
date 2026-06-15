require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")
map("i", "<C-q>", "<", { desc = "Type <" })
map("i", "<C-e>", ">", { desc = "Type >" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprev<CR>", { desc = "Previous buffer" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle Explorer" })
map("n", "<leader>E", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Explorer (current file)" })

-- Terminaux dédiés
map({ "n", "t" }, "<leader>gg", function()
  require("nvchad.term").toggle { pos = "float", id = "lazygit", cmd = "lazygit" }
end, { desc = "Terminal lazygit" })

map({ "n", "t" }, "<leader>tc", function()
  require("nvchad.term").toggle { pos = "vsp", id = "claudecode", cmd = "claude", size = 0.45 }
end, { desc = "Terminal Claude Code" })

map({ "n", "t" }, "<leader>ts", function()
  require("nvchad.term").toggle { pos = "sp", id = "devserver" }
end, { desc = "Terminal serveur" })
