vim.pack.add { 'https://www.github.com/wtfox/jellybeans.nvim' }
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
  'o:hor20-oCursor',
  'r:block-rCursor',
  'v:block-vCursor',
}
