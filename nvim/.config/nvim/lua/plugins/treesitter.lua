return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { 'bash', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'python', 'query', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    {
      'nvim-treesitter/nvim-treesitter-context',
      opts = {
        enable = true,
        max_lines = 0,
        trim_scope = 'outer',
        mode = 'cursor',
      },
      config = function()
        local treesitter_context = require 'treesitter-context'

        vim.keymap.set('n', '<leader>tc', treesitter_context.toggle, { desc = '[T]oggle [C]ontext' })
      end,
    },
  },
}
