return {
  {
    'folke/which-key.nvim',
    opts = {
      preset = 'helix',
      delay = 0,
    },
    init = function()
      local which_key = require 'which-key'
      which_key.add {
        { '<leader>b', group = '[B]uffer' },
        { '<leader>e', group = '[E]xplore' },
        { '<leader>o', group = '[O]ther' },
        { '<leader>s', group = '[S]urround' },
        { '<leader>t', group = '[T]elescope' },
      }
    end,
  },
}
