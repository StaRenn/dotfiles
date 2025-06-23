local options = {
  lsp_fallback = true,

  notify_on_error = true,

  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "stylelint", "prettier" },
    scss = { "stylelint", "prettier" },
    sass = { "stylelint", "prettier" },
    html = { "prettier" },
    sh = { "shfmt" },
  },
}

require("conform").setup(options)
