return {
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      overrides = function(colors)
        return {
          WinSeparator = { fg = colors.orange },
        }
      end,
    },
    config = function(_, opts)
      require('cyberdream').setup(opts)
      vim.cmd.colorscheme 'cyberdream'
    end,
  },
}
