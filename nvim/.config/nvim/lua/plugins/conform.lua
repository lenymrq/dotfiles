return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- python = { 'isort', 'black' },
        python = { 'black' },
        c = { 'clang-format' },
        json = { 'jq' },
        javascript = { 'prettier' },
        html = { 'prettier' },
      },
    },
  },
}
