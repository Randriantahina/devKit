local options = {
  formatters_by_ft = {
    lua        = { "stylua" },
    php        = { "pint" },
    blade      = { "pint" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    vue        = { "prettier" },
    css        = { "prettier" },
    html       = { "prettier" },
    json       = { "prettier" },
    markdown   = { "prettier" },
  },

  formatters = {
    pint = {
      command = function()
        local local_pint = vim.fn.getcwd() .. "/vendor/bin/pint"
        if vim.fn.executable(local_pint) == 1 then
          return local_pint
        end
        return "pint"
      end,
    },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
