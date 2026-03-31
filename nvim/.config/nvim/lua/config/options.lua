-- General
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.mouse = 'a'
vim.o.switchbuf = 'usetab'
vim.o.undofile = true

vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

-- UI
vim.o.breakindent = true
vim.o.breakindentopt = 'list:-1'
vim.o.colorcolumn = '+1'
vim.o.cursorline = true
vim.o.linebreak = true
vim.o.list = true
vim.o.number = true
vim.o.relativenumber = false
vim.o.pumblend = 0
vim.o.pumheight = 12
vim.o.ruler = false
vim.o.scrolloff = 10
vim.o.shortmess = 'CFOSWaco'
vim.o.showmode = false
vim.o.signcolumn = 'yes'
vim.o.splitbelow = true
vim.o.splitkeep = 'screen'
vim.o.splitright = true
vim.o.winborder = 'single'
vim.o.winblend = 0
vim.o.wrap = false
vim.o.title = true

vim.o.cursorlineopt = 'screenline,number' -- Show cursor line per screen line

-- UI symbols
vim.opt.fillchars = { eob = ' ', fold = '╌' }
vim.opt.listchars = { extends = '…', nbsp = '␣', precedes = '…', tab = '» ' }

-- Folds
vim.o.foldlevel = 10
vim.o.foldmethod = 'indent'
vim.o.foldnestmax = 10
vim.o.foldtext = ''

-- Editing
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.formatoptions = 'rqnl1j'
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.infercase = true
vim.o.shiftwidth = 4
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.tabstop = 8
vim.o.virtualedit = 'block'

vim.o.iskeyword = '@,48-57,_,192-255,-' -- Treat dash as `word` textobject part

-- Completion
vim.o.complete = '.,w,b,kspell'
vim.o.completeopt = 'menuone,noselect,fuzzy,nosort'

-- Diagnostics
vim.diagnostic.config {
  severity_sort = true,
  signs = false,
  underline = { severity = { min = 'HINT', max = 'ERROR' } },
  virtual_lines = false,
  virtual_text = true,
  update_in_insert = false,
}
