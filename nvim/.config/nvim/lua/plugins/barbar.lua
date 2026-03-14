return {
  'romgrk/barbar.nvim',
  -- dependencies = {
  --   'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
  --   'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  -- },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  event = 'BufEnter',
  opts = {
    animation = false,
    auto_hide = false,
  },
  keys = {
    {
      '<s-h>',
      '<cmd>BufferPrevious<cr>',
      noremap = true,
      silent = true,
      desc = 'Switch to previous buffer',
    },
    {
      '<s-l>',
      '<cmd>BufferNext<cr>',
      noremap = true,
      silent = true,
      desc = 'Switch to next buffer',
    },
    {
      '<c-h>',
      '<cmd>BufferMovePrevious<cr>',
      noremap = true,
      silent = true,
      desc = 'Switch current buffer with previous',
    },
    {
      '<c-l>',
      '<cmd>BufferMoveNext<cr>',
      noremap = true,
      silent = true,
      desc = 'Switch current buffer with next',
    },
    {
      '<leader>bp',
      '<cmd>BufferPick<cr>',
      noremap = true,
      silent = true,
      desc = 'Pick buffer',
    },
  },
  version = '^1.0.0',
}
