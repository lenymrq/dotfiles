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
      vim.keymap.set('n', '<C-x>', MiniBufremove.delete, { desc = 'Delete Current Buffer' })
      vim.keymap.set('n', '<C-X>', function()
        MiniBufremove.delete(0, true)
      end, { desc = 'Force Delete Current Buffer' })

      require('mini.comment').setup()

      local process_items_opts = { kind_priority = { Text = -1, Snippet = -1 } }
      local process_items = function(items, base)
        return MiniCompletion.default_process_items(items, base, process_items_opts)
      end
      require('mini.completion').setup {
        lsp_completion = {
          source_func = 'omnifunc',
          auto_setup = true,
          process_items = process_items,
        },
      }

      vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })

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

      local map = require 'mini.map'
      map.setup {
        symbols = { encode = map.gen_encode_symbols.dot '4x2' },
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.diff(),
          map.gen_integration.diagnostic(),
        },
      }
      for _, key in ipairs { 'n', 'N', '*', '#' } do
        local rhs = key .. 'zv' .. '<cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>'
        vim.keymap.set('n', key, rhs)
      end
      vim.keymap.set('n', '<leader>tm', MiniMap.toggle, { desc = '[T]oggle [M]ap' })
      vim.keymap.set('n', '<leader>mf', MiniMap.toggle_focus, { desc = '[F]ocus [M]ap' })
      vim.keymap.set('n', '<leader>mr', MiniMap.refresh, { desc = '[R]efresh [M]ap' })
      vim.keymap.set('n', '<leader>ms', MiniMap.toggle_side, { desc = 'Change [M]ap [S]ide' })

      require('mini.move').setup()

      require('mini.pairs').setup()

      require('mini.surround').setup()

      require('mini.trailspace').setup()
      vim.keymap.set('n', '<leader>ot', MiniTrailspace.trim, { desc = 'Remove [T]railing whitespace' })
    end,
  },
}
