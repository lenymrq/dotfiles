return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup()
      require('mini.comment').setup()

      require('mini.completion').setup {
        delay = { completion = 0, info = 0, signature = 0 },
      }

      require('mini.pairs').setup()

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

      require('mini.files').setup()
      vim.keymap.set('n', '<leader><leader>', MiniFiles.open, { desc = 'File explorer' })

      require('mini.git').setup()

      require('mini.jump').setup {
        delay = {
          highlight = 0,
        },
      }

      -- require('mini.hues').setup { background = '#000000', foreground = '#ffffff', saturation = 'high', accent = 'azure' }

      require('mini.icons').setup()
      MiniIcons.tweak_lsp_kind()

      require('mini.notify').setup()
      require('mini.starter').setup()
      require('mini.statusline').setup()
      require('mini.tabline').setup()
    end,
  },
}
