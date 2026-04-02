vim.pack.add { 'https://github.com/folke/snacks.nvim' }

require('snacks').setup {
  quickfile = { enabled = true },
  picker = {
    win = {
      input = {
        keys = {
          ['<tab>'] = { 'list_down', mode = { 'n', 'i' } },
          ['<s-tab>'] = { 'list_up', mode = { 'n', 'i' } },
        },
      },
      list = {
        keys = {
          ['<tab>'] = { 'list_down', mode = { 'n', 'i' } },
          ['<s-tab>'] = { 'list_up', mode = { 'n', 'i' } },
        },
      },
    },
  },
}

vim.keymap.set('n', '<leader>fD', Snacks.picker.diagnostics_buffer, { desc = 'Buffer diagnostics' })
vim.keymap.set('n', '<leader>fb', Snacks.picker.buffers, { desc = 'Open buffers' })
vim.keymap.set('n', '<leader>fd', Snacks.picker.diagnostics, { desc = 'Diagnostics' })
vim.keymap.set('n', '<leader>ff', Snacks.picker.files, { desc = 'Files' })
vim.keymap.set('n', '<leader>fg', Snacks.picker.grep, { desc = 'Grep' })
vim.keymap.set('n', '<leader>fq', Snacks.picker.qflist, { desc = 'Quickfix' })
vim.keymap.set('n', '<leader>fr', Snacks.picker.resume, { desc = 'Resume' })
vim.keymap.set('n', '<leader>ft', Snacks.picker.treesitter, { desc = 'Treesitter' })
vim.keymap.set('n', '<leader>fn', Snacks.picker.notifications, { desc = 'Notifications' })

vim.keymap.set('n', '<leader>gS', function()
  Snacks.picker.git_stash {
    win = {
      input = {
        keys = {
          ['<tab>'] = { 'list_down', mode = { 'n', 'i' } },
        },
      },
    },
  }
end, { desc = 'Stash' })
vim.keymap.set('n', '<leader>gb', Snacks.picker.git_branches, { desc = 'Branch' })
vim.keymap.set('n', '<leader>gd', function()
  Snacks.picker.git_diff {
    win = {
      input = {
        keys = {
          ['<tab>'] = { 'list_down', mode = { 'n', 'i' } },
        },
      },
    },
  }
end, { desc = 'Diff' })
vim.keymap.set('n', '<leader>gf', Snacks.picker.git_files, { desc = 'Files' })
vim.keymap.set('n', '<leader>gs', function()
  Snacks.picker.git_status {
    win = {
      input = {
        keys = {
          ['<tab>'] = { 'list_down', mode = { 'n', 'i' } },
        },
      },
    },
  }
end, { desc = 'Status' })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(_)
    vim.keymap.set('n', 'grr', Snacks.picker.lsp_references, { desc = 'References' })
    vim.keymap.set('n', 'grd', Snacks.picker.lsp_definitions, { desc = 'Definitions' })
    vim.keymap.set('n', 'grD', Snacks.picker.lsp_declarations, { desc = 'Declarations' })
    vim.keymap.set('n', 'grt', Snacks.picker.lsp_type_definitions, { desc = 'Type definitions' })
    vim.keymap.set('n', 'gri', Snacks.picker.lsp_implementations, { desc = 'Implementations' })
    vim.keymap.set('n', 'grs', Snacks.picker.lsp_symbols, { desc = 'Symbols' })
  end,
})
