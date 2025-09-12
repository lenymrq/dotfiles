return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup()
      require('mini.surround').setup()
      require('mini.comment').setup()

      require('mini.basics').setup {
        options = {
          basic = false,
        },
        mappings = {
          basic = false,
        },
        autocommands = {
          basic = true,
        },
      }

      require('mini.jump').setup {
        delay = {
          highlight = 0,
        },
      }

      require('mini.notify').setup()

      local mouse_scrolled = false
      for _, scroll in ipairs { 'Up', 'Down' } do
        local key = '<ScrollWheel' .. scroll .. '>'
        vim.keymap.set({ '', 'i' }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      require('mini.statusline').setup()
      require('mini.tabline').setup()

      local mini_files = require 'mini.files'
      mini_files.setup {
        mappings = {
          close = 'q',
        },
      }
      vim.keymap.set('n', '<leader><leader>', mini_files.open, { desc = 'File explorer' })
    end,
  },
}
