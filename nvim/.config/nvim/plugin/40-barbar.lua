vim.pack.add { 'https://github.com/romgrk/barbar.nvim' }

require('barbar').setup {
  animation = false,
  auto_hide = true,
}

vim.keymap.set('n', '<s-h>', '<cmd>BufferPrevious<cr>', { desc = 'Go to previous buffer in barbar' })
vim.keymap.set('n', '<s-l>', '<cmd>BufferNext<cr>', { desc = 'Go to next buffer in barbar' })

vim.keymap.set('n', '<a-s-h>', '<cmd>BufferMovePrevious<cr>', { desc = 'Switch current buffer with next in barbar' })
vim.keymap.set('n', '<a-s-l>', '<cmd>BufferMoveNext<cr>', { desc = 'Switch current buffer with previous in barbar' })
