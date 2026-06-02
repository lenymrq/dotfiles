vim.pack.add { 'https://www.github.com/nvim-mini/mini.nvim' }

local hues = require('mini.hues')

if vim.o.background == 'dark' then
    hues.setup { background = '#1a1a1a', foreground = '#e5e5e5', saturation = 'high', accent = 'azure', }
elseif vim.o.background == 'light' then
    hues.setup { background = '#e5e5e5', foreground = '#1a1a1a', saturation = 'high', accent = 'azure', }
else
    vim.cmd.colorscheme 'default'
end

vim.g.colors_name = 'lescheme'
