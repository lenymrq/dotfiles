vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })

vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window left' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window down' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window up' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window right' })

-- Buffer navigation
vim.keymap.set('n', '<S-h>', '<cmd>:bprev<CR>', { silent = true, desc = 'Focus previous buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>:bnext<CR>', { silent = true, desc = 'Focus next buffer' })

-- Completion
local function cmp_active()
  return vim.fn.pumvisible() ~= 0
end

vim.keymap.set('i', '<CR>', function()
  if cmp_active() then
    return '<C-y>'
  else
    return '<CR>'
  end
end, { expr = true, silent = true })
vim.keymap.set('i', '<Tab>', function()
  if cmp_active() then
    return '<C-n>'
  else
    return '<Tab>'
  end
end, { expr = true, silent = true })
vim.keymap.set('i', '<S-Tab>', function()
  if cmp_active() then
    return '<C-p>'
  else
    return '<S-Tab>'
  end
end, { expr = true, silent = true })
