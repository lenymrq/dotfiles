return {
  {
    'folke/which-key.nvim',
    opts = {
      preset = 'helix',
      delay = 0,
      spec = {
        { '<leader>b', group = '[B]uffer' },
        { '<leader>e', group = '[E]xplore' },
        { '<leader>o', group = '[O]ther' },
        {
          '<leader>s',
          group = '[S]urround',
          { '<leader>sa', desc = '[A]dd [S]urrounding' },
          { '<leader>sd', desc = '[D]elete [S]urrounding' },
          { '<leader>sf', desc = '[F]ind [S]urrounding' },
          { '<leader>sF', desc = '[F]ind [S]urrounding Left' },
          { '<leader>sh', desc = '[H]ighlight [S]urrounding' },
          { '<leader>sr', desc = '[R]eplace [S]urrounding' },
        },
        { '<leader>t', group = '[T]elescope' },
        {
          'gr',
          group = 'LSP',
          { 'gra', desc = 'LSP Code [A]ctions' },
          { 'grn', desc = 'LSP Re[n]ame' },
        },
        {
          '<leader>d',
          group = '[D]AP',
          { '<leader>ds', desc = '[S]tep' },
        },
      },
    },
  },
}
