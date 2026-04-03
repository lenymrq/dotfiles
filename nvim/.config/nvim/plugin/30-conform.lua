vim.pack.add { 'https://www.github.com/stevearc/conform.nvim' }
require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'black' },
  },
}
vim.keymap.set('n', 'grf', function()
  require('conform').format { lsp_fallback = true }
end, { desc = 'Format' })
