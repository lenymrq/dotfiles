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

    -- diff
    require('mini.diff').setup {
      view = {
        style = 'sign',
        signs = { add = '┃', change = '┃', delete = '' },
      },
      delay = {
        text_change = 50,
      },
    }
    vim.keymap.set('n', '<leader>go', MiniDiff.toggle_overlay, { desc = 'Git diff overlay' })

    -- snippets
    require('mini.snippets').setup()

    -- completion
    local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
    local process_items = function(items, base)
      return MiniCompletion.default_process_items(items, base, process_items_opts)
    end
    require('mini.completion').setup {
      lsp_completion = {
        source_func = 'omnifunc',
        auto_setup = false,
        process_items = process_items,
      },
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
      end,
    })

    vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
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

    -- clue
    local leader_group_clues = {
      { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
      { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
      { mode = 'n', keys = '<Leader>f', desc = '+Find' },
      { mode = 'n', keys = '<Leader>g', desc = '+Git' },
      { mode = 'x', keys = '<Leader>g', desc = '+Git' },
      { mode = 'n', keys = '<Leader>l', desc = '+Language' },
      { mode = 'x', keys = '<Leader>l', desc = '+Language' },
      { mode = 'n', keys = '<Leader>o', desc = '+Other' },
      { mode = 'n', keys = '<Leader>s', desc = '+Surround' },
    }

    local miniclue = require 'mini.clue'
    miniclue.setup {
      clues = {
        leader_group_clues,
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.windows { submode_resize = true },
        miniclue.gen_clues.z(),
      },
      triggers = {
        { mode = { 'n', 'x' }, keys = '<leader>' }, -- leader triggers
        { mode = 'n', keys = '\\' }, -- mini.basics
        { mode = { 'n', 'x' }, keys = '[' }, -- mini.bracketed
        { mode = { 'n', 'x' }, keys = ']' },
        { mode = 'i', keys = '<c-x>' }, -- Built-in completion
        { mode = { 'n', 'x' }, keys = 'g' }, -- `g` key
        { mode = { 'n', 'x' }, keys = "'" }, -- Marks
        { mode = { 'n', 'x' }, keys = '`' },
        { mode = { 'n', 'x' }, keys = '"' }, -- Registers
        { mode = { 'i', 'c' }, keys = '<c-r>' },
        { mode = 'n', keys = '<c-w>' }, -- Window commands
        { mode = { 'n', 'x' }, keys = 'z' }, -- `z` key
      },
      window = {
        delay = 0,
      },
    }

    -- extra
    require('mini.extra').setup()

    -- hipatterns
    local hipatterns = require 'mini.hipatterns'
    hipatterns.setup {
      highlighters = {
        -- Highlight a fixed set of common words. Will be highlighted in any place,
        -- not like "only in comments".
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

        -- Highlight hex color string (#aabbcc) with that color as a background
        hex_color = hipatterns.gen_highlighter.hex_color { style = '#' },
      },
    }

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
