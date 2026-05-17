local now = Config.now

now(function()
  vim.pack.add { 'https://github.com/rebelot/kanagawa.nvim' }

  require('kanagawa').setup {
    dimInactive = true,
    theme = 'wave',
    commentStyle = { italic = false },
    keywordStyle = { italic = false },
  }

  vim.cmd.colorscheme 'kanagawa'

  vim.opt.guicursor = {
    'c:block-MiniStatuslineModeCommand',
    'i:block-MiniStatuslineModeInsert',
    'n:block-MiniStatuslineModeNormal',
    'o:block-MiniStatuslineModeOther',
    'r:block-MiniStatuslineModeReplace',
    'v:block-MiniStatuslineModeVisual',
  }
end)
