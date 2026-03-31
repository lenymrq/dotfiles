return {
  'wtfox/jellybeans.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    flat_ui = false,
    on_highlights = function(hl, _)
      hl.iCursor = { bg = hl.MiniStatuslineModeInsert.bg, fg = hl.MiniStatuslineModeInsert.bg }
      hl.nCursor = { bg = hl.MiniStatuslineModeNormal.bg, fg = hl.MiniStatuslineModeNormal.bg }
      hl.vCursor = { bg = hl.MiniStatuslineModeVisual.bg, fg = hl.MiniStatuslineModeVisual.bg }
    end,
  },
  config = function(_, opts)
    require('jellybeans').setup(opts)
    vim.cmd.colorscheme 'jellybeans'
    vim.opt.guicursor = {
      'i:block-iCursor',
      'n:block-nCursor',
      'o-r:hor20-oCursor',
      'v:block-vCursor',
    }
  end,
}
