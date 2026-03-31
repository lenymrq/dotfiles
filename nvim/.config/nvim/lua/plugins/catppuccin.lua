return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = true,
  opts = {
    background = {
      light = 'latte',
      dark = 'mocha',
    },
    float = {
      transparent = true,
      solid = false,
    },
    dim_inactive = {
      enabled = true,
      percentage = 0.2,
    },
    custom_highlights = function(colors)
      return {
        iCursor = { bg = colors.green, fg = colors.base },
        nCursor = { bg = colors.blue, fg = colors.base },
        vCursor = { bg = colors.mauve, fg = colors.base },
      }
    end,
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme 'catppuccin-nvim'

    vim.opt.guicursor = {
      'i:block-iCursor',
      'n:block-nCursor',
      'v:block-vCursor',
    }
  end,
}
