local later = Config.later

later(function()
  -- Indent
  vim.pack.add { 'https://github.com/saghen/blink.indent' }

  require('blink.indent').setup {
    static = {
      char = '▏',
    },
    scope = {
      char = '▏',
      highlights = { 'BlinkIndentScope' },
    },
  }
end)
