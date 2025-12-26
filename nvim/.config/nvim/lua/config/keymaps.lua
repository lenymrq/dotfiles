vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Buffer navigation
vim.keymap.set('n', '<S-h>', '<cmd>:bprev<CR>', { silent = true, desc = 'Focus previous buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>:bnext<CR>', { silent = true, desc = 'Focus next buffer' })

-- Window handling
vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window left' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window down' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window up' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window right' })
