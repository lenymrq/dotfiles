return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'black' },
    },
  },
  keys = {
    {
      '<leader>lf',
      function()
        require('conform').format { lsp_fallback = true }
      end,
      desc = 'Format buffer',
    },
  },
}
