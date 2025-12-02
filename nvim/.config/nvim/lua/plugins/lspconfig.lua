return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      local servers = {
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
                  reportUnusedImport = 'warning',
                  reportUnusedClass = 'hint',
                  reportUnusedFunction = 'hint',
                  reportUnusedVariable = 'hint',
                },
              },
            },
          },
        },

        lua_ls = {},
        clangd = {},
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'black',
        'stylua',
        'clang-format',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        automatic_enable = vim.tbl_keys(servers or {}),
      }

      for server_name, config in pairs(servers) do
        vim.lsp.config(server_name, config)
      end
    end,
  },
}
