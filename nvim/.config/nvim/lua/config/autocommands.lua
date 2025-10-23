-- Useful on alacritty, st...
vim.api.nvim_create_autocmd('ExitPre', {
  desc = 'Restore beam cursor when exiting nvim',
  group = vim.api.nvim_create_augroup('Exit', { clear = true }),
  command = 'set guicursor=a:ver90',
  desc = 'Set cursor back to beam when leaving Neovim.',
})
