vim.pack.add {
  'https://www.github.com/wtfox/jellybeans.nvim',
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
}

if vim.o.background == 'dark' then
  require('jellybeans').setup {
    flat_ui = false,
    on_highlights = function(hl, pl)
      hl.cCursor = { bg = pl.biloba_flower, fg = hl.background }
      hl.iCursor = { bg = pl.green_smoke, fg = pl.background }
      hl.nCursor = { bg = pl.morning_glory, fg = pl.background }
      hl.oCursor = { bg = pl.grey_chateau, fg = hl.background }
      hl.rCursor = { bg = pl.raw_sienna, fg = hl.background }
      hl.vCursor = { bg = pl.koromiko, fg = hl.background }
    end,
  }
  vim.cmd.colorscheme 'jellybeans'
  vim.opt.guicursor = {
    'c:block-cCursor',
    'i:block-iCursor',
    'n:block-nCursor',
    'o:block-oCursor',
    'r:block-rCursor',
    'v:block-vCursor',
  }
elseif vim.o.background == 'light' then
  require('catppuccin').setup {
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
        cCursor = { bg = colors.lavender, fg = colors.base },
        iCursor = { bg = colors.green, fg = colors.base },
        nCursor = { bg = colors.blue, fg = colors.base },
        oCursor = { bg = colors.overlay0, fg = colors.base },
        rCursor = { bg = colors.rosewater, fg = colors.base },
        vCursor = { bg = colors.mauve, fg = colors.base },
      }
    end,
  }
  vim.cmd.colorscheme 'catppuccin'
  vim.opt.guicursor = {
    'c:block-cCursor',
    'i:block-iCursor',
    'n:block-nCursor',
    'o:block-oCursor',
    'r:block-rCursor',
    'v:block-vCursor',
  }
end
