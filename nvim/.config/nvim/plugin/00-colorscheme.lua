local now = Config.now

now(function()
  vim.pack.add { { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' } }

  local transparent = true

  require('catppuccin').setup {
    flavour = 'auto',
    background = {
      light = 'latte',
      dark = 'mocha',
    },
    transparent_background = transparent,
    float = {
      transparent = true,
      solid = true,
    },
    dim_inactive = {
      enabled = not transparent,
      percentage = 0.2,
    },
    lsp_styles = {
      underlines = {
        errors = { 'undercurl' },
        hints = { 'undercurl' },
        warnings = { 'undercurl' },
        information = { 'undercurl' },
        ok = { 'undercurl' },
      },
    },
    custom_highlights = function(colors)
      return {
        cCursor = { bg = colors.peach, fg = colors.base },
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
end)
