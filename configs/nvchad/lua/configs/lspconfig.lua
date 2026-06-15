require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "intelephense", "volar", "ts_ls", "tailwindcss" }
vim.lsp.enable(servers)
