local now_if_args = Config.now_if_args

now_if_args(function()
  vim.pack.add { 'https://www.github.com/NMAC427/guess-indent.nvim' }
  require('guess-indent').setup {
    on_tab_options = {
      ['expandtab'] = false,
      ['shiftwidth'] = 0,
    },
  }
end)
