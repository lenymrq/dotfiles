-- Change CWD
vim.keymap.set('n', '<leader>op', function()
  vim.cmd.lcd '%:p:h'
end, { desc = 'Change local CWD to current file location' })
vim.keymap.set('n', '<leader>oP', function()
  vim.cmd.cd '%:p:h'
end, { desc = 'Change global CWD to current file location' })

-- Windows
vim.keymap.set('n', '<c-s-h>', '<c-w>H', { desc = 'Move window to far left'})
vim.keymap.set('n', '<c-s-j>', '<c-w>J', { desc = 'Move window to far bottom'})
vim.keymap.set('n', '<c-s-k>', '<c-w>K', { desc = 'Move window to far top'})
vim.keymap.set('n', '<c-s-l>', '<c-w>L', { desc = 'Move window to far right'})
