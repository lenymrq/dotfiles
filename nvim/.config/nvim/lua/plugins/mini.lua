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

      require('mini.base16').setup {
        -- gruvbox dark hard
        palette = {
          base00 = '#1d2021',
          base01 = '#3c3836',
          base02 = '#504945',
          base03 = '#665c54',
          base04 = '#bdae93',
          base05 = '#d5c4a1',
          base06 = '#ebdbb2',
          base07 = '#fbf1c7',
          base08 = '#fb4934',
          base09 = '#fe8019',
          base0A = '#fabd2f',
          base0B = '#b8bb26',
          base0C = '#8ec07c',
          base0D = '#83a598',
          base0E = '#d3869b',
          base0F = '#d65d0e',
        },
      }

      require('mini.icons').setup()
      MiniIcons.tweak_lsp_kind()

      require('mini.notify').setup()
      require('mini.starter').setup()
      require('mini.statusline').setup()
      require('mini.tabline').setup()
    end,
  },
}
