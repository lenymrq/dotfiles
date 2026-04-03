vim.cmd.packadd 'nohlsearch'

vim.cmd.packadd 'nvim.difftool'

vim.cmd.packadd 'nvim.undotree'
vim.keymap.set('n', '<leader>u', require('undotree').open, { desc = 'Open undo tree' })
