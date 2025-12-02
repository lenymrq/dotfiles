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
      desc = '[D]ap [C]ontinue',
    },
    {
      '<leader>dsi',
      function()
        require('dap').step_into()
      end,
      desc = '[D]ap [S]tep [I]n',
    },
    {
      '<leader>dso',
      function()
        require('dap').step_over()
      end,
      desc = '[D]ap [S]tep [O]ver',
    },
    {
      '<leader>dsx',
      function()
        require('dap').step_out()
      end,
      desc = '[D]ap [S]tep Out',
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = '[D]ap Toggle [B]reakpoint',
    },
    {
      '<leader>dx',
      function()
        require('dap').terminate()
      end,
      desc = '[D]ap Terminate Session',
    },
    {
      '<leader>du',
      function()
        require('dapui').toggle()
      end,
      desc = '[D]ap Toggle [U]I',
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
