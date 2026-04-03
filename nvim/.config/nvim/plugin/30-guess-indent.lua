vim.pack.add { 'https://www.github.com/NMAC427/guess-indent.nvim' }
require('guess-indent').setup {
  on_tab_options = {
    ['expandtab'] = false,
    ['shiftwidth'] = 0,
  },
}
