return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',

        build = 'make',

        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<esc>'] = require('telescope.actions').close,
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>tb', builtin.buffers, { desc = 'Find Buffers' })
      vim.keymap.set('n', '<leader>td', builtin.diagnostics, { desc = 'Find Diagnostics' })
      vim.keymap.set('n', '<leader>tf', builtin.find_files, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>tg', builtin.live_grep, { desc = 'Find By Grep' })
      vim.keymap.set('n', '<leader>th', builtin.help_tags, { desc = 'Find Help' })
      vim.keymap.set('n', '<leader>tk', builtin.keymaps, { desc = 'Find Keymaps' })
      vim.keymap.set('n', '<leader>tr', builtin.resume, { desc = 'Find Resume' })
      vim.keymap.set('n', '<leader>tt', builtin.builtin, { desc = 'Find Telescope Builtins' })
      vim.keymap.set('n', '<leader>tw', builtin.grep_string, { desc = 'Find Current Word' })
      vim.keymap.set('n', '<leader>t/', builtin.current_buffer_fuzzy_find, { desc = 'Find In Buffer' })

      -- LSP
      vim.keymap.set('n', 'gri', builtin.lsp_implementations, { desc = 'LSP Find Implementations' })
      vim.keymap.set('n', 'grr', builtin.lsp_references, { desc = 'LSP Find References' })
      vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { desc = 'LSP Find Type Definitions' })
      vim.keymap.set('n', 'grd', builtin.lsp_definitions, { desc = 'LSP Find Definitions' })
    end,
  },
}
