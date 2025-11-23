return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.basics').setup {
        options = { basic = false, extra_ui = true },
        mappings = {
          move_with_alt = true,
        },
      }

      require('mini.icons').setup()
      MiniIcons.mock_nvim_web_devicons()
      MiniIcons.tweak_lsp_kind()

      require('mini.misc').setup()
      MiniMisc.setup_auto_root()
      MiniMisc.setup_restore_cursor()
      MiniMisc.setup_termbg_sync()
      vim.keymap.set('n', '<leader>or', MiniMisc.resize_window, { desc = '[R]estore Window Size' })
      vim.keymap.set('n', '<leader>tz', MiniMisc.zoom, { desc = '[T]oggle [Z]oom' })

      require('mini.notify').setup()
      vim.keymap.set('n', '<leader>en', MiniNotify.show_history, { desc = '[E]xplore [N]otifications' })

      require('mini.starter').setup()

      require('mini.statusline').setup()

      require('mini.tabline').setup()

      require('mini.extra').setup()

      require('mini.bracketed').setup()

      require('mini.bufremove').setup()
      vim.keymap.set('n', '<leader>bd', MiniBufremove.delete, { desc = '[D]elete Current [B]uffer' })
      vim.keymap.set('n', '<leader>bD', function()
        MiniBufremove.delete(0, true)
      end, { desc = 'Force [D]elete Current [B]uffer' })

      require('mini.comment').setup()

      require('mini.diff').setup()

      require('mini.files').setup()
      vim.keymap.set('n', '<leader>ed', MiniFiles.open, { desc = '[E]xplore Current Working [D]irectory' })
      vim.keymap.set('n', '<leader>ef', function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
      end, { desc = '[E]xplore Current [F]ile Directory' })

      require('mini.git').setup()

      local hipatterns = require 'mini.hipatterns'
      local hi_words = MiniExtra.gen_highlighter.words
      hipatterns.setup {
        highlighters = {
          fixme = hi_words({ 'FIXME', 'Fixme', 'fixme' }, 'MiniHipatternsFixme'),
          hack = hi_words({ 'HACK', 'Hack', 'hack' }, 'MiniHipatternsHack'),
          todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
          note = hi_words({ 'NOTE', 'Note', 'note' }, 'MiniHipatternsNote'),

          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }

      require('mini.jump').setup()

      require('mini.keymap').setup()
      MiniKeymap.map_multistep('i', '<Tab>', { 'pmenu_next' })
      MiniKeymap.map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
      MiniKeymap.map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
      MiniKeymap.map_multistep('i', '<BS>', { 'minipairs_bs' })

      require('mini.move').setup()

      require('mini.pairs').setup()

      require('mini.surround').setup()

      require('mini.trailspace').setup()
      vim.keymap.set('n', '<leader>ot', MiniTrailspace.trim, { desc = 'Remove [T]railing whitespace' })
    end,
  },
}
