return {
  {
    'folke/which-key.nvim',
    opts = {
      preset = 'helix',
      delay = 0,
      spec = {
        { '<leader>b', group = 'Buffer' },
        { '<leader>e', group = 'Explore' },
        {
          '<leader>o',
          group = 'Other',
          {
            '<leader>ot',
            group = 'Toggle',
          },
        },
        {
          '<leader>s',
          group = 'Surround',
          { '<leader>sa', desc = 'Add Surrounding' },
          { '<leader>sd', desc = 'Delete Surrounding' },
          { '<leader>sf', desc = 'Find Surrounding' },
          { '<leader>sF', desc = 'Find Surrounding Left' },
          { '<leader>sh', desc = 'Highlight Surrounding' },
          { '<leader>sr', desc = 'Replace Surrounding' },
        },
        { '<leader>f', group = 'Find' },
        {
          'gr',
          group = 'LSP',
          { 'gra', desc = 'LSP Code Actions' },
          { 'grn', desc = 'LSP Rename' },
        },
        {
          '<leader>d',
          group = 'DAP',
          { '<leader>ds', desc = 'Step' },
        },
        { '<leader>g', group = 'Git' },
        {
          '<leader>w',
          group = 'Window',
          { '<leader>wr', group = 'Restore' },
        },
      },
    },
  },
}
