return {
  {
    'echasnovski/mini.nvim',
    config = function()
      vim.cmd.colorscheme 'miniautumn'
      require('mini.basics').setup {
        options = {
          basic = false,
          extra_ui = true,
          win_borders = 'double',
        },
        mappings = {
          basic = false,
          option_toggle_prefix = [[\]],
          windows = false,
          move_with_alt = true,
        },
        autocommands = {
          basic = true,
        },
      }

      require('mini.icons').setup()
      MiniIcons.mock_nvim_web_devicons()
      MiniIcons.tweak_lsp_kind()

      require('mini.misc').setup()
      MiniMisc.setup_auto_root()
      MiniMisc.setup_restore_cursor()
      MiniMisc.setup_termbg_sync()

      require('mini.notify').setup()
      vim.keymap.set('n', '<leader>en', MiniNotify.show_history, { desc = 'Explore Notifications' })

      require('mini.starter').setup()

      require('mini.statusline').setup()

      require('mini.tabline').setup()

      require('mini.extra').setup()

      local mouse_scrolled = false
      for _, scroll in ipairs { 'Up', 'Down' } do
        local key = '<ScrollWheel' .. scroll .. '>'
        vim.keymap.set({ '', 'i' }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end
      local animate = require 'mini.animate'
      animate.setup {
        cursor = { enable = false },
        scroll = {
          enable = true,
          timing = animate.gen_timing.linear { duration = 4, unit = 'step' },
          subscroll = animate.gen_subscroll.equal {
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          },
        },
        resize = { enable = true },
        open = { enable = true },
        close = { enable = true },
      }
      vim.keymap.set('n', '<leader>ota', function()
        MiniAnimate.config.scroll.enable = not MiniAnimate.config.scroll.enable
      end, { desc = 'Toggle Scroll Animations' })

      require('mini.bracketed').setup()

      require('mini.bufremove').setup()
      vim.keymap.set('n', '<leader>bd', MiniBufremove.delete, { desc = 'Delete Current Buffer' })
      vim.keymap.set('n', '<leader>bD', function()
        MiniBufremove.delete(0, true)
      end, { desc = 'Force Delete Current Buffer' })

      require('mini.comment').setup()

      local process_items_opts = { kind_priority = { Text = -1, Snippet = 0 } }
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
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'snacks_picker_input',
        desc = 'Disable mini.completion for snacks picker',
        group = vim.api.nvim_create_augroup('user_mini', {}),
        command = 'lua vim.b.minicompletion_disable=true',
      })

      require('mini.snippets').setup {
        mappings = { expand = '', jump_next = '<Tab>', jump_prev = '<S-Tab>' },
      }
      local make_stop = function()
        local au_opts = { pattern = '*:n', once = true }
        au_opts.callback = function()
          while MiniSnippets.session.get() do
            MiniSnippets.session.stop()
          end
        end
        vim.api.nvim_create_autocmd('ModeChanged', au_opts)
      end
      local opts = { pattern = 'MiniSnippetsSessionStart', callback = make_stop }
      vim.api.nvim_create_autocmd('User', opts)

      require('mini.diff').setup {
        mappings = {
          apply = '<leader>gh',
          reset = '<leader>gH',
          textobject = '<leader>gh',
        },
      }
      vim.keymap.set('n', '<leader>go', MiniDiff.toggle_overlay, { desc = 'Toggle Diff Overlay' })

      require('mini.files').setup()
      vim.keymap.set('n', '<leader>ed', MiniFiles.open, { desc = 'Explore Current Working Directory' })
      vim.keymap.set('n', '<leader>ef', function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
      end, { desc = 'Explore Current File Directory' })

      require('mini.git').setup()
      local diff_folds = 'foldmethod=expr foldexpr=v:lua.MiniGit.diff_foldexpr() foldlevel=0'
      vim.cmd('au FileType git,diff setlocal ' .. diff_folds)

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

      local indentscope = require 'mini.indentscope'
      indentscope.setup {
        symbol = '│',
        draw = {
          delay = 0,
          animation = indentscope.gen_animation.none(),
        },
        options = {
          try_as_border = true,
        },
      }

      require('mini.jump').setup {
        delay = {
          highlight = 0,
        },
      }
      local jump_stop = function()
        if not MiniJump.state.jumping then
          if vim.api.nvim_get_mode()['mode'] == 'n' then
            return '<cmd>nohlsearch<CR>'
          end
          return '<Esc>'
        end
        MiniJump.stop_jumping()
      end
      vim.keymap.set({ 'n', 'x', 'o' }, '<Esc>', jump_stop, { expr = true })

      require('mini.jump2d').setup {
        allowed_lines = {
          blank = false,
          cursor_at = false,
        },
        labels = 'sadfjklewcmpgh',
        mappings = { start_jumping = '<leader>j' },
        view = {
          dim = true,
        },
      }

      require('mini.keymap').setup()
      MiniKeymap.map_multistep('i', '<Tab>', { 'pmenu_next' })
      MiniKeymap.map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
      MiniKeymap.map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
      MiniKeymap.map_multistep('i', '<BS>', { 'minipairs_bs' })

      require('mini.move').setup()

      require('mini.pairs').setup()

      local surround = require 'mini.surround'
      surround.setup {
        highlight_duration = 1000,
        mappings = {
          add = '<leader>sa',
          delete = '<leader>sd',
          find = '<leader>sf',
          find_left = '<leader>sF',
          highlight = '<leader>sh',
          replace = '<leader>sr',

          suffix_last = '',
          suffix_next = '',
        },
      }

      require('mini.trailspace').setup()
      vim.keymap.set('n', '<leader>ow', MiniTrailspace.trim, { desc = 'Remove Trailing Whitespace' })
    end,
  },
}
