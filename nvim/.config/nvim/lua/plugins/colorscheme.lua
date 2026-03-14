return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
  opts = {
    background = {
      light = 'latte',
      dark = 'mocha',
    },
    dim_inactive = {
      enabled = true,
      percentage = 0.2,
    },
    custom_highlights = function(colors)
      return {
        Cursor = { bg = colors.blue, fg = colors.base },
        CursorIM = { bg = colors.green, fg = colors.base },
      }
    end,
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme 'catppuccin-nvim'

    vim.opt.guicursor = {
      'n-v-c-sm:block-Cursor',
      'i:block-CursorIM',
      'r-cr-o:hor20-CursorIM',
    }
  end,
}
