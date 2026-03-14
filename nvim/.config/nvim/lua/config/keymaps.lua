-- Change CWD
vim.keymap.set('n', '<leader>op', function()
  vim.cmd.lcd '%:p:h'
end, { desc = 'Change local CWD to current file location' })
vim.keymap.set('n', '<leader>oP', function()
  vim.cmd.cd '%:p:h'
end, { desc = 'Change global CWD to current file location' })
