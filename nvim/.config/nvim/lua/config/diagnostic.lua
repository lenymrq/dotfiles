vim.diagnostic.config {
  severity_sort = true,
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅙',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '󰋼',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
  virtual_text = true,
}
