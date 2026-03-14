return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    picker = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    statuscolumn = { enabled = true },
  },
  keys = {
    {
      '<leader>f:',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command history',
    },
    {
      '<leader>fb',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>ff',
      function()
        Snacks.picker.files()
      end,
      desc = 'Files',
    },
    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches()
      end,
      desc = 'Git branches',
    },
    {
      '<leader>gl',
      function()
        Snacks.picker.git_log()
      end,
      desc = 'Git log',
    },
    {
      '<leader>gL',
      function()
        Snacks.picker.git_log_line()
      end,
      desc = 'Git log line',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Git status',
    },
    {
      '<leader>gS',
      function()
        Snacks.picker.git_stash()
      end,
      desc = 'Git stash',
    },
    {
      '<leader>gd',
      function()
        Snacks.picker.git_diff()
      end,
      desc = 'Git diff (hunks)',
    },
    {
      '<leader>gf',
      function()
        Snacks.picker.git_log_file()
      end,
      desc = 'Git log lile',
    },
    {
      '<leader>fl',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer lines',
    },
    {
      '<leader>fg',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>fw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Visual selection or word',
      mode = { 'n', 'x' },
    },
    {
      '<leader>f"',
      function()
        Snacks.picker.registers()
      end,
      desc = 'Registers',
    },
    {
      '<leader>f/',
      function()
        Snacks.picker.search_history()
      end,
      desc = 'Search history',
    },
    {
      '<leader>fa',
      function()
        Snacks.picker.autocmds()
      end,
      desc = 'Autocmds',
    },
    {
      '<leader>fC',
      function()
        Snacks.picker.commands()
      end,
      desc = 'Commands',
    },
    {
      '<leader>fd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>fD',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = 'Buffer diagnostics',
    },
    {
      '<leader>fh',
      function()
        Snacks.picker.help()
      end,
      desc = 'Help pages',
    },
    {
      '<leader>fH',
      function()
        Snacks.picker.highlights()
      end,
      desc = 'Highlights',
    },
    {
      '<leader>fj',
      function()
        Snacks.picker.jumps()
      end,
      desc = 'Jumps',
    },
    {
      '<leader>fk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Keymaps',
    },
    {
      '<leader>fm',
      function()
        Snacks.picker.marks()
      end,
      desc = 'Marks',
    },
    {
      '<leader>fq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix list',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>fu',
      function()
        Snacks.picker.undo()
      end,
      desc = 'Undo history',
    },
    {
      '<leader>fc',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },
    {
      '<leader>ld',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = 'Goto definition',
    },
    {
      '<leader>lD',
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = 'Goto declaration',
    },
    {
      '<leader>lr',
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = 'References',
    },
    {
      '<leader>li',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = 'Goto implementation',
    },
    {
      '<leader>lt',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = 'Goto type definition',
    },
    {
      '<leader>lci',
      function()
        Snacks.picker.lsp_incoming_calls()
      end,
      desc = 'Calls incoming',
    },
    {
      '<leader>lco',
      function()
        Snacks.picker.lsp_outgoing_calls()
      end,
      desc = 'Calls outgoing',
    },
    {
      '<leader>ls',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = 'LSP symbols',
    },
    {
      '<leader>lS',
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = 'LSP workspace symbols',
    },
    {
      '<leader>cr',
      function()
        Snacks.rename.rename_file()
      end,
      desc = 'Rename file',
    },
  },
}
