return {
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig',
    },
    config = function()
      local mason_lspconfig = require 'mason-lspconfig'

      local configs = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = 'strict',
                diagnosticSeverityOverrides = {
                  reportMissingTypeStubs = false,
                  -- Report unknown
                  reportUnknownArgumentType = false,
                  reportUnknownLambdaType = false,
                  reportUnknownMemberType = false,
                  reportUnknownParameterType = false,
                  reportUnknownVariableType = false,
                  -- Report unused
                  reportUnusedCallResult = false,
                  reportUnusedImport = 'hint',
                  reportUnusedClass = 'hint',
                  reportUnusedFunction = 'hint',
                  reportUnusedVariable = 'hint',
                },
              },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(configs or {})
      mason_lspconfig.setup { ensure_installed = ensure_installed }

      for server_name, config in pairs(configs) do
        vim.lsp.config(server_name, config)
      end
    end,
  },
}
