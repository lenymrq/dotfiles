return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'mfussenegger/nvim-dap-python',
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  keys = {
    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = 'Dap Continue',
    },
    {
      '<leader>dsi',
      function()
        require('dap').step_into()
      end,
      desc = 'Dap Step In',
    },
    {
      '<leader>dso',
      function()
        require('dap').step_over()
      end,
      desc = 'Dap Step Over',
    },
    {
      '<leader>dsx',
      function()
        require('dap').step_out()
      end,
      desc = 'Dap Step Out',
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Dap Toggle Breakpoint',
    },
    {
      '<leader>dx',
      function()
        require('dap').terminate()
      end,
      desc = 'Dap Terminate Session',
    },
    {
      '<leader>du',
      function()
        require('dapui').toggle()
      end,
      desc = 'Dap Toggle UI',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local dappy = require 'dap-python'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
    }

    dappy.setup 'debugpy-adapter'

    dapui.setup()

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
