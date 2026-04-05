-- ###########
-- # Options #
-- ###########
-- General
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.mouse = 'a'
vim.o.undofile = true

-- UI
vim.o.breakindent = true

vim.o.cursorline = true
vim.o.colorcolumn = '+1'
vim.o.linebreak = true
vim.o.list = true
vim.o.listchars = 'tab:> ,nbsp:␣,extends:>,precedes:<'
vim.o.number = true
vim.o.pumblend = 0
vim.o.pumheight = 12
vim.o.relativenumber = true
vim.o.scrolloff = 10
vim.o.showmode = true
vim.o.signcolumn = 'yes'
vim.o.splitbelow = true
vim.o.splitkeep = 'screen'
vim.o.splitright = true
vim.o.title = true
vim.o.winblend = 0
vim.o.winborder = 'single'
vim.o.wrap = false

-- UI2
require('vim._core.ui2').enable { enable = true }

-- Folds
vim.o.foldlevel = 10
vim.o.foldmethod = 'indent'
vim.o.foldnestmax = 10
vim.o.foldtext = ''

-- Editing
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.infercase = true
vim.o.shiftwidth = 4
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.tabstop = 8
vim.o.virtualedit = 'block'

-- Completion
vim.o.complete = '.,w,b,kspell'
vim.o.completeopt = 'menuone,noselect,fuzzy,nosort'

-- Diagnostics
vim.diagnostic.config {
  severity_sort = true,
  signs = false,
  virtual_text = true,
  update_in_insert = false,
}

-- ###########
-- # Keymaps #
-- ###########
-- Change CWD
vim.keymap.set('n', '<leader>op', function()
  vim.cmd.lcd '%:h'
end, { desc = 'Change local CWD to current file location' })
vim.keymap.set('n', '<leader>oP', function()
  vim.cmd.cd '%:h'
end, { desc = 'Change global CWD to current file location' })

-- Windows
vim.keymap.set('n', '<c-h>', '<c-w>h', { desc = 'Focus left' })
vim.keymap.set('n', '<c-j>', '<c-w>j', { desc = 'Focus down' })
vim.keymap.set('n', '<c-k>', '<c-w>k', { desc = 'Focus up' })
vim.keymap.set('n', '<c-l>', '<c-w>l', { desc = 'Focus right' })

vim.keymap.set('n', '<c-s-h>', '<c-w>H', { desc = 'Move window to far left' })
vim.keymap.set('n', '<c-s-j>', '<c-w>J', { desc = 'Move window to far bottom' })
vim.keymap.set('n', '<c-s-k>', '<c-w>K', { desc = 'Move window to far top' })
vim.keymap.set('n', '<c-s-l>', '<c-w>L', { desc = 'Move window to far right' })

-- Move with alt
vim.keymap.set('i', '<m-h>', '<left>', { desc = 'Left', noremap = false })
vim.keymap.set('i', '<m-j>', '<down>', { desc = 'Down', noremap = false })
vim.keymap.set('i', '<m-k>', '<up>', { desc = 'Up', noremap = false })
vim.keymap.set('i', '<m-l>', '<right>', { desc = 'Right', noremap = false })

-- Move by visible line
vim.keymap.set({ 'n', 'x' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true })
vim.keymap.set({ 'n', 'x' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Copy/paste with system clipboard
vim.keymap.set({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', 'gp', '"+p', { desc = 'Paste from system clipboard' })
-- Paste in Visual with `P` to not copy selected text
vim.keymap.set('x', 'gp', '"+P', { desc = 'Paste from system clipboard' })

-- Toggle keymaps
vim.keymap.set('n', '\\h', '<cmd>let v:hlsearch = 1 - v:hlsearch<cr>', { desc = 'Toggle search highlight' })
vim.keymap.set('n', '\\w', '<cmd>setlocal wrap!<cr>', { desc = 'Toggle search highlight' })

-- #######
-- # LSP #
-- #######
vim.pack.add { 'https://github.com/neovim/nvim-lspconfig' } -- Further configuration is done in /lsp

vim.lsp.enable 'basedpyright'
vim.lsp.enable 'lua_ls'
vim.lsp.enable 'clangd'
