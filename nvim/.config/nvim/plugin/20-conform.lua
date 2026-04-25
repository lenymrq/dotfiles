local later = Config.later

later(function()
  vim.pack.add { 'https://www.github.com/stevearc/conform.nvim' }
  require('conform').setup {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
      yaml = { 'yamlfmt' },
    },
  }
  vim.keymap.set('n', 'grf', function()
    require('conform').format { lsp_fallback = true }
  end, { desc = 'Format' })
end)
