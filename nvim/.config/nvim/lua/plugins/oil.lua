return {
  {
    'stevearc/oil.nvim',
    config = function()
      local oil = require 'oil'
      oil.setup {
        float = {
          max_width = 0.75,
          max_height = 0.75,
        },
        keymaps = {
          ['<C-h>'] = false,
          ['<Esc>'] = { 'actions.close', mode = 'n' },
        },
      }
      vim.keymap.set({ 'n', 'v' }, '<leader><leader>', function()
        oil.open_float(nil, { preview = {} })
      end, { desc = 'File explorer' })
    end,
  },
}
