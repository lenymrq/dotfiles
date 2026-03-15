return {
  'nvim-mini/mini.nvim',
  version = false,
  config = function()
    -- basics
    require('mini.basics').setup {
      options = {
        basic = true,
        extra_ui = true,
        win_borders = 'auto',
      },
      mappings = {
        basic = true,
        option_toggle_prefix = [[\]],
        windows = true,
        move_with_alt = true,
      },
      autocommands = {
        basic = true,
        relnum_in_visual_mode = true,
      },
    }

    -- icons
    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()
    MiniIcons.tweak_lsp_kind()

    -- notify
    require('mini.notify').setup()

    -- statusline
    require('mini.statusline').setup()

    -- ai
    require('mini.ai').setup()

    -- comment
    require('mini.comment').setup()

    -- snippets
    require('mini.snippets').setup()

    -- completion
    require('mini.completion').setup { delay = { completion = 0, info = 0, signature = 0 } }
    vim.api.nvim_create_autocmd('BufEnter', {
      callback = function()
        if vim.bo.buftype == 'prompt' then
          vim.b.minicompletion_disable = true
        end
      end,
    })

    -- keymap
    local map_multistep = require('mini.keymap').map_multistep
    map_multistep('i', '<Tab>', { 'pmenu_next' })
    map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
    map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
    map_multistep('i', '<BS>', { 'minipairs_bs' })

    -- move
    require('mini.move').setup { options = { reindent_linewise = false } }

    -- pairs
    require('mini.pairs').setup()

    -- surround
    require('mini.surround').setup {
      mappings = {
        add = '<leader>sa',
        delete = '<leader>sd',
        find = '<leader>sf',
        find_left = '<leader>sF',
        highlight = '<leader>sh',
        replace = '<leader>sr',

        suffix_last = 'l',
        suffix_next = 'n',
      },
    }

    -- bracketed
    require('mini.bracketed').setup()

    -- bufremove
    require('mini.bufremove').setup()
    vim.keymap.set('n', '<leader>bd', MiniBufremove.delete, { desc = 'Remove buffer' })
    vim.keymap.set('n', '<leader>bD', function()
      MiniBufremove.delete(nil, true)
    end, { desc = 'Force remove buffer' })

    -- files
    require('mini.files').setup { windows = { preview = true } }
    vim.keymap.set('n', '<leader>ef', MiniFiles.open, { desc = 'Open file explorer' })
    vim.keymap.set('n', '<leader>eF', function()
      MiniFiles.open(vim.api.nvim_buf_get_name(0))
    end, { desc = "Open file explorer at current file's directory" })
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesActionRename',
      callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
      end,
    })

    -- trailspace
    require('mini.trailspace').setup()
    vim.keymap.set('n', '<leader>ot', MiniTrailspace.trim, { desc = 'Trim trailing whitespaces' })

    -- indentscope
    require('mini.indentscope').setup {
      symbol = '▏',
      draw = {
        delay = 0,
        animation = require('mini.indentscope').gen_animation.none(),
      },
    }

    -- jump
    require('mini.jump').setup { delay = { highlight = 0 } }
    vim.keymap.set({ 'n', 'x', 'o' }, '<Esc>', function()
      if not MiniJump.state.jumping then
        return '<Esc>'
      end
      MiniJump.stop_jumping()
    end, { expr = true, desc = 'Stop jumping' })

    -- misc
    require('mini.misc').setup()
    MiniMisc.setup_auto_root()
    MiniMisc.setup_termbg_sync()
    MiniMisc.setup_restore_cursor()
    vim.keymap.set('n', '<leader>oz', MiniMisc.zoom, { desc = 'Zoom current buffer' })
  end,
}
